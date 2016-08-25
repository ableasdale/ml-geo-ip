package com.marklogic.support.geoip;

import com.marklogic.client.DatabaseClient;
import com.marklogic.client.DatabaseClientFactory;
import com.marklogic.client.document.XMLDocumentManager;
import com.marklogic.client.extra.xom.XOMHandle;
import nu.xom.Document;
import nu.xom.Element;
import org.apache.commons.codec.digest.DigestUtils;
import org.apache.commons.vfs2.FileObject;
import org.apache.commons.vfs2.FileSystemException;
import org.apache.commons.vfs2.FileSystemManager;
import org.apache.commons.vfs2.VFS;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;

/**
 * Created by ableasdale on 22/08/2016.
 *
 * TODO - this works but it's very serial right now... Threads? Larger batches?
 *
 */
public class CommonsVFSTest {

    private static Logger LOG = LoggerFactory.getLogger("CommonsVFSTest");

    public static void main(String[] args) {
        LOG.info("Testing Commons VFS..");
        LOG.info(new java.io.File("").getAbsolutePath());
        LOG.info(System.getProperty("user.dir"));
        //LOG.info(getClass().getProtectionDomain().getCodeSource().getLocation().getPath());
        DatabaseClient client = DatabaseClientFactory.newClient(Config.HOST, Config.PORT, Config.DATABASE, Config.USER, Config.PASSWD, DatabaseClientFactory.Authentication.DIGEST);

        try {
            FileSystemManager fsManager = VFS.getManager();
            FileObject file = fsManager.resolveFile( "zip://"+new java.io.File("").getAbsolutePath()+"/src/main/resources/source-data-files/cr.zip" );
            LOG.info(file.toString());
            FileObject db = file.getChild("cr").getChild("anp_ips.dat");
            BufferedReader in = new BufferedReader(new InputStreamReader(db.getContent().getInputStream()));
            String line = null;

            while((line = in.readLine()) != null) {

                long start = Long.parseLong(line.substring(0,10));
                long end = Long.parseLong(line.substring(10,20));

                LOG.info("Start: "+start+" End: "+end+" Country: "+line.substring(20,22));

                Element root = new Element("ip2country");
                Document doc = new Document(root);

                Element from = new Element("IP-From");
                from.appendChild(String.valueOf(start));
                root.appendChild(from);

                Element to = new Element("IP-TO");
                to.appendChild(String.valueOf(end));
                root.appendChild(to);

                Element cc = new Element("CountryCode");
                cc.appendChild(line.substring(20,22));
                root.appendChild(cc);

                // Now write the XOM Obj to MarkLogic
                XMLDocumentManager docMgr = client.newXMLDocumentManager();
                docMgr.write(String.format("/%s.xml", DigestUtils.md5Hex(doc.toXML())), new XOMHandle(doc));
            }
        } catch (FileSystemException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }

        client.release();
    }
}
