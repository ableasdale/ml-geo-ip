package com.marklogic.support.geoip;

import com.marklogic.client.DatabaseClient;
import com.marklogic.client.DatabaseClientFactory;
import com.marklogic.client.document.XMLDocumentManager;
import com.marklogic.client.extra.xom.XOMHandle;
import nu.xom.Document;
import nu.xom.Element;
import org.apache.commons.codec.digest.DigestUtils;
import org.apache.commons.csv.CSVFormat;
import org.apache.commons.csv.CSVRecord;
import org.apache.commons.vfs2.FileObject;
import org.apache.commons.vfs2.FileSystemException;
import org.apache.commons.vfs2.FileSystemManager;
import org.apache.commons.vfs2.VFS;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.text.MessageFormat;

/**
 * Created by ableasdale on 01/09/2016.
 * <p>
 * Processes "allCountries.zip" from:
 * http://download.geonames.org/export/zip/
 * <p>
 * <pre>
 * country code      : iso country code, 2 characters
 * postal code       : varchar(20)
 * place name        : varchar(180)
 * admin name1       : 1. order subdivision (state) varchar(100)
 * admin code1       : 1. order subdivision (state) varchar(20)
 * admin name2       : 2. order subdivision (county/province) varchar(100)
 * admin code2       : 2. order subdivision (county/province) varchar(20)
 * admin name3       : 3. order subdivision (community) varchar(100)
 * admin code3       : 3. order subdivision (community) varchar(20)
 * latitude          : estimated latitude (wgs84)
 * longitude         : estimated longitude (wgs84)
 * accuracy          : accuracy of lat/lng from 1=estimated to 6=centroid
 * </pre>
 */
public class ProcessGeonamesPostCodeData {

    private static Logger LOG = LoggerFactory.getLogger("ProcessGeonamesPostCodeData");

    public static void main(String[] args) {

        //LOG.info(new java.io.File("").getAbsolutePath());
        //LOG.info(System.getProperty("user.dir"));
        //LOG.info(getClass().getProtectionDomain().getCodeSource().getLocation().getPath());
        DatabaseClient client = DatabaseClientFactory.newClient(Config.HOST, Config.PORT, Config.DATABASE, Config.USER, Config.PASSWD, DatabaseClientFactory.Authentication.DIGEST);
        String filepath = "zip://" + new java.io.File("").getAbsolutePath() + "/src/main/resources/source-data-files/allCountries.zip";

        try {
            FileSystemManager fsManager = VFS.getManager();
            FileObject file = fsManager.resolveFile(filepath);
            LOG.info(file.toString());
            FileObject fo = file.getChild("allCountries.txt");

            BufferedReader in = new BufferedReader(new InputStreamReader(fo.getContent().getInputStream()));
            Iterable<CSVRecord> records = CSVFormat.TDF.withQuote(null).parse(in);

            for (CSVRecord record : records) {

                Element root = new Element("location-data");
                Document doc = new Document(root);

                Element countryCode = new Element("country-code");
                countryCode.appendChild(record.get(0));
                root.appendChild(countryCode);

                Element postalCode = new Element("postal-code");
                postalCode.appendChild(record.get(1));
                root.appendChild(postalCode);

                Element placeName = new Element("place-name");
                placeName.appendChild(record.get(2));
                root.appendChild(placeName);

                Element admin1Name = new Element("admin1-name");
                admin1Name.appendChild(record.get(3));
                root.appendChild(admin1Name);

                Element admin1Code = new Element("admin1-code");
                admin1Code.appendChild(record.get(4));
                root.appendChild(admin1Code);

                Element admin2Name = new Element("admin2-name");
                admin2Name.appendChild(record.get(5));
                root.appendChild(admin2Name);

                Element admin2Code = new Element("admin2-code");
                admin2Code.appendChild(record.get(6));
                root.appendChild(admin2Code);

                Element admin3Name = new Element("admin3-name");
                admin3Name.appendChild(record.get(7));
                root.appendChild(admin3Name);

                Element admin3Code = new Element("admin3-code");
                admin3Code.appendChild(record.get(8));
                root.appendChild(admin3Code);

                Element latitude = new Element("latitude");
                latitude.appendChild(record.get(9));
                root.appendChild(latitude);

                Element longitude = new Element("longitude");
                longitude.appendChild(record.get(10));
                root.appendChild(longitude);

                Element accuracy = new Element("accuracy");
                accuracy.appendChild(record.get(11));
                root.appendChild(accuracy);

                XMLDocumentManager docMgr = client.newXMLDocumentManager();
                docMgr.write(String.format("/%s.xml", DigestUtils.md5Hex(doc.toXML())), new XOMHandle(doc));

                //LOG.info(record.get(0) + " | " + record.get(5) + " | " + record.get(11));
                //LOG.info(doc.toXML());
            }

        } catch (FileSystemException e) {
            LOG.error(MessageFormat.format("File: {0} is unavailable", filepath), e);
        } catch (IOException e) {
            LOG.error("An IO Exception was encountered", e);
        }

        client.release();
    }

}
