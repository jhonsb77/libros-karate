import com.intuit.karate.Results;
import com.intuit.karate.Runner;
import com.intuit.karate.junit5.Karate;
import net.masterthought.cucumber.Configuration;
import net.masterthought.cucumber.ReportBuilder;
import org.apache.commons.io.FileUtils;
//import org.junit.jupiter.api.Test;


import java.io.File;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

public class BooksRunner {

//    @Karate.Test
//    void testParallel(){
//        //String tag=System.getProperty("tag");
//        Results results =  Runner.path("classpath:Books").outputCucumberJson(true).tags("@crearEspecifico").parallel(1);
//        generateReport(results.getReportDir());
//    }

    @Karate.Test
    Karate testTags() {
        return Karate.run("classpath:Books").tags("@crearEspecifico").relativeTo(getClass());
    }

    public static void generateReport(String karateOutputPath){
        Collection<File> jsonFiles = FileUtils.listFiles(new File(karateOutputPath), new String[]{"json"}, true);
        List<String> jsonPaths = new ArrayList<>(jsonFiles.size());
        jsonFiles.forEach(file -> jsonPaths.add(file.getAbsolutePath()));
        Configuration config = new Configuration(new File("build"), "Libros API");
        ReportBuilder reportBuilder = new ReportBuilder(jsonPaths, config);
        reportBuilder.generateReports();
    }
}
