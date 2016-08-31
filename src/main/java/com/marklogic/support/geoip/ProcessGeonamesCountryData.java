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
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.io.Reader;
import java.text.MessageFormat;

/**
 * Created by ableasdale on 31/08/2016.
 * <p>
 * Takes this file:
 * http://download.geonames.org/export/dump/allCountries.zip (unzipped) and processes it into XML
 * <p>
 * Read more at:
 * http://download.geonames.org/export/dump/readme.txt
 * <pre>
 * geonameid         : integer id of record in geonames database
 * name              : name of geographical point (utf8) varchar(200)
 * asciiname         : name of geographical point in plain ascii characters, varchar(200)
 * alternatenames    : alternatenames, comma separated, ascii names automatically transliterated, convenience attribute from alternatename table, varchar(10000)
 * latitude          : latitude in decimal degrees (wgs84)
 * longitude         : longitude in decimal degrees (wgs84)
 * feature class     : see http://www.geonames.org/export/codes.html, char(1)
 * feature code      : see http://www.geonames.org/export/codes.html, varchar(10)
 * country code      : ISO-3166 2-letter country code, 2 characters
 * cc2               : alternate country codes, comma separated, ISO-3166 2-letter country code, 200 characters
 * admin1 code       : fipscode (subject to change to iso code), see exceptions below, see file admin1Codes.txt for display names of this code; varchar(20)
 * admin2 code       : code for the second administrative division, a county in the US, see file admin2Codes.txt; varchar(80)
 * admin3 code       : code for third level administrative division, varchar(20)
 * admin4 code       : code for fourth level administrative division, varchar(20)
 * population        : bigint (8 byte int)
 * elevation         : in meters, integer
 * dem               : digital elevation model, srtm3 or gtopo30, average elevation of 3''x3'' (ca 90mx90m) or 30''x30'' (ca 900mx900m) area in meters, integer. srtm processed by cgiar/ciat.
 * timezone          : the timezone id (see file timeZone.txt) varchar(40)
 * modification date : date of last modification in yyyy-MM-dd format
 * </pre>
 */
public class ProcessGeonamesCountryData {

    private static Logger LOG = LoggerFactory.getLogger("CutTabDelineatedFile");

    public static void main(String[] args) {

        DatabaseClient client = DatabaseClientFactory.newClient(Config.HOST, Config.PORT, Config.DATABASE, Config.USER, Config.PASSWD, DatabaseClientFactory.Authentication.DIGEST);
        String filepath = new java.io.File("").getAbsolutePath() + "/src/main/resources/source-data-files/allCountries.txt";

        try {
            Reader in = new FileReader(filepath);
            Iterable<CSVRecord> records = CSVFormat.TDF.withQuote(null).parse(in);
            for (CSVRecord record : records) {

                Element root = new Element("geonames-data");
                Document doc = new Document(root);

                Element id = new Element("geonameid");
                id.appendChild(record.get(0));
                root.appendChild(id);

                Element name = new Element("name");
                name.appendChild(record.get(1));
                root.appendChild(name);

                Element asciiname = new Element("asciiname");
                asciiname.appendChild(record.get(2));
                root.appendChild(asciiname);

                Element alternatenames = new Element("alternatenames");
                alternatenames.appendChild(record.get(3));
                root.appendChild(alternatenames);

                Element latitude = new Element("latitude");
                latitude.appendChild(record.get(4));
                root.appendChild(latitude);

                Element longitude = new Element("longitude");
                longitude.appendChild(record.get(5));
                root.appendChild(longitude);

                Element featureClass = new Element("feature-class");
                featureClass.appendChild(record.get(6));
                root.appendChild(featureClass);

                Element featureCode = new Element("feature-code");
                featureCode.appendChild(record.get(7));
                root.appendChild(featureCode);

                Element countryCode = new Element("country-code");
                countryCode.appendChild(record.get(8));
                root.appendChild(countryCode);

                Element cc2 = new Element("cc2");
                cc2.appendChild(record.get(9));
                root.appendChild(cc2);

                Element admin1Code = new Element("admin1-code");
                admin1Code.appendChild(record.get(10));
                root.appendChild(admin1Code);

                Element admin2Code = new Element("admin2-code");
                admin2Code.appendChild(record.get(11));
                root.appendChild(admin2Code);

                Element admin3Code = new Element("admin3-code");
                admin3Code.appendChild(record.get(12));
                root.appendChild(admin3Code);

                Element admin4Code = new Element("admin4-code");
                admin4Code.appendChild(record.get(13));
                root.appendChild(admin4Code);

                Element population = new Element("population");
                population.appendChild(record.get(14));
                root.appendChild(population);

                Element elevation = new Element("elevation");
                elevation.appendChild(record.get(15));
                root.appendChild(elevation);

                Element dem = new Element("dem");
                dem.appendChild(record.get(16));
                root.appendChild(dem);

                Element timezone = new Element("timezone");
                timezone.appendChild(record.get(17));
                root.appendChild(timezone);

                Element modificationDate = new Element("modification-date");
                modificationDate.appendChild(record.get(18));
                root.appendChild(modificationDate);

                XMLDocumentManager docMgr = client.newXMLDocumentManager();
                docMgr.write(String.format("/%s.xml", DigestUtils.md5Hex(doc.toXML())), new XOMHandle(doc));
                
//                LOG.debug("Debug: "+record.get(0) + " " + record.get(1) + " " + record.get(18));
//                LOG.info(doc.toXML());
            }
        } catch (FileNotFoundException e) {
            LOG.error(MessageFormat.format("File: {0} is unavailable", filepath), e);
        } catch (IOException e) {
            LOG.error("An IO Exception was encountered", e);
        } catch (RuntimeException e) {
            LOG.error("A RuntimeException was encountered", e);
        }

        client.release();

        /*
        LineIterator it = null;
        try {
            it = FileUtils.lineIterator(new File(f), "UTF-8");
        } catch (IOException e) {
            e.printStackTrace();
        }
        try {
            while (it.hasNext()) {
                String line = it.nextLine();
                //LOG.info(line);

                StringTokenizer st = new StringTokenizer(line , "\t");
                LOG.info("T:"+st.countTokens());
                while (st.hasMoreTokens()) {
                   st.nextToken();
                }


                // do something with line
            }
        } finally {
            it.close();
        }*/
    }
}
