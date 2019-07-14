
# Compile 
- 1st, you Java application need a main function. If it doesn't contain one, create one like the following code and call a desired test in it (This is an example from BTreeBench in JDB3 benchmark suite that I named the new class `BTreeBenchTest` and calling the `test_001()` test function:

```
public class BTreeBenchTest {
    static public void main(String[] args) throws IOException, InterruptedException {
        BTreeBench b = new BTreeBench();
        b.test_001();
    }
}
```
- Make sure you have all the necessary imports and locations done correctly, esp the BTreeBench one:

```
package org.apache.jdbm;
import org.apache.jdbm.BTreeBench;
import java.io.IOException;
import java.util.Map;

```

- Now, depending on the script for compilation, you need some modifications:
- - for the [`pom.xml`](pom.xml), I changed settings in a way that it compiles and packs all the dependencies etc into a single jar file:
```
<plugin>
    <groupId>org.apache.maven.plugins</groupId>
    <artifactId>maven-assembly-plugin</artifactId>
    <executions>
        <execution>
            <phase>package</phase>
            <goals>
                <goal>single</goal>
            </goals>
            <configuration>
                <archive>
                <manifest>
                    <mainClass>
                        org.apache.jdbm.BTreeBenchTest
                    </mainClass>
                </manifest>
                </archive>
                <descriptorRefs>
                    <descriptorRef>jar-with-dependencies</descriptorRef>
                </descriptorRefs>
            </configuration>
        </execution>
    </executions>
</plugin>

```
- Then, you define what is your main function `org.apache.jdbm.BTreeBenchTest`.
- Time to compile, I used the following command to compile:
```
mvn -Dmaven.test.skip=true  package
```
which creates a `jdbm-3.0-xxx.java` file you will run. Sometimes, it complains about a missing tmp file, you can try once more with removing the skip test flag.

- A sample script that compiles the bench for you [JDB3_sample](JSB3_sample). You can change the bench name ...

# Run in ZSim
- install openJDK and add the path in `~/.bashrc` file:
```
export PATH=/home/aming/Work/jdk1.8.0_211/bin:$PATH
```

- `Command to run:` put this in your xxx.cfg file:
```
command = "java -jar jdbm-3.0-SNAPSHOT-jar-with-dependencies.jar";
```
