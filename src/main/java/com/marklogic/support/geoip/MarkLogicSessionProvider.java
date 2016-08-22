package com.marklogic.support.geoip;

import com.marklogic.xcc.ContentSource;
import com.marklogic.xcc.ContentSourceFactory;
import com.marklogic.xcc.Session;
import com.marklogic.xcc.exceptions.XccConfigException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.net.URI;
import java.net.URISyntaxException;

/**
 * Created by ableasdale on 25/05/2016.
 */
public class MarkLogicSessionProvider {

    private ContentSource cs;

    private MarkLogicSessionProvider() {
        Logger LOG = LoggerFactory.getLogger("com.marklogic.support.geoip.MarkLogicSessionProvider");
        LOG.debug("Initialising ContentSource");
        try {
            cs = ContentSourceFactory.newContentSource(new URI(Config.MARKLOGIC_XCC_URI));
        } catch (XccConfigException e) {
            LOG.error("com.marklogic.support.geoip.Config Issue", e);
        } catch (URISyntaxException e) {
            LOG.error("URI Issue", e);
        }
    }

    private static MarkLogicSessionProvider getInstance() {
        return LazyHolder.INSTANCE;
    }

    private static ContentSource getContentSource() {
        return getInstance().cs;
    }

    public static Session getSession() {
        return getContentSource().newSession();
    }

    private static class LazyHolder {
        private static final MarkLogicSessionProvider INSTANCE = new MarkLogicSessionProvider();
    }
}
