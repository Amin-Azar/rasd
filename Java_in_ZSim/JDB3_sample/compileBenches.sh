







echo "Creating Bench Name"
# BENCHAMRKS
benchName=BTreeBenchTest

echo "Creating Pom File for $benchName"

# CREATE PM FILE
bash generatePom.sh $benchName

echo "Compiling ..."
#COMPILE IT
mvn package > ${benchName}_compile.out
mvn -Dmaven.test.skip=true  package

echo "Renaming to target/jdbm-3.0-$benchName.jar"
mv target/jdbm-3.0-SNAPSHOT-jar-with-dependencies.jar target/jdbm-3.0-$benchName.jar

echo "Running ..." 
java -jar target/jdbm-3.0-$benchName.jar

echo "Done!"
