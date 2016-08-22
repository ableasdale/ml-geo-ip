package com.marklogic.support.geoip;

import com.marklogic.client.DatabaseClient;
import com.marklogic.client.DatabaseClientFactory;
import com.marklogic.client.document.XMLDocumentManager;
import com.marklogic.client.extra.xom.XOMHandle;
import nu.xom.Document;
import nu.xom.Element;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * Created by ableasdale on 22/08/2016.
 */
public class MLJavaClientAPI {

    private static Logger LOG = LoggerFactory.getLogger("MLJavaClientAPI");

    public static void main(String[] args) {

        // Start: 3717201920 End: 3718840319 Country: KR

        Element root = new Element("ip2country");
        Document doc = new Document(root);

        Element from = new Element("IP-From");
        from.appendChild("3717201920");
        root.appendChild(from);

        Element to = new Element("IP-TO");
        to.appendChild("3718840319");
        root.appendChild(to);

        Element cc = new Element("CountryCode");
        cc.appendChild("KR");
        root.appendChild(cc);

//        String result = doc.toXML();
//        System.out.println(result);


        DatabaseClient client = DatabaseClientFactory.newClient(Config.HOST, Config.PORT, Config.DATABASE, Config.USER, Config.PASSWD, DatabaseClientFactory.Authentication.DIGEST);
        LOG.info(client.getDatabase());
        XMLDocumentManager docMgr = client.newXMLDocumentManager();
        docMgr.write("/test.xml", new XOMHandle(doc));
        // Do stuff...
        client.release();
    }
}
