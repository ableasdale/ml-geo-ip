package com.marklogic.support.geoip;

import org.apache.commons.vfs2.FileObject;
import org.apache.commons.vfs2.FileSystemException;
import org.apache.commons.vfs2.FileSystemManager;
import org.apache.commons.vfs2.VFS;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.BufferedReader;
import java.io.File;
import java.io.IOException;
import java.io.InputStreamReader;

/**
 * Created by ableasdale on 22/08/2016.
 */
public class CommonsVFSTest {

    private static Logger LOG = LoggerFactory.getLogger("CommonsVFSTest");

    public static void main(String[] args) {
        LOG.info("Testing Commons VFS..");
        LOG.info(new java.io.File("").getAbsolutePath());
        LOG.info(System.getProperty("user.dir"));
        //LOG.info(getClass().getProtectionDomain().getCodeSource().getLocation().getPath());

        try {
            FileSystemManager fsManager = VFS.getManager();
            FileObject file = fsManager.resolveFile( "zip://"+new java.io.File("").getAbsolutePath()+"/src/main/resources/source-data-files/cr.zip" );
            LOG.info(file.toString());
            FileObject db = file.getChild("cr").getChild("anp_ips.dat");
            BufferedReader in = new BufferedReader(new InputStreamReader(db.getContent().getInputStream()));
            String line = null;

            while((line = in.readLine()) != null) {
                LOG.info(line);
            }
            /*
            for ( int i = 0; i < children.length; i++ )
            {
                LOG.info( children[ i ].getName().getBaseName() );
                //LOG.info(children[i].getName().)
            }*/


        } catch (FileSystemException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }

    }
}
