CPATH='.:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar'

rm -rf student-submission
rm -rf grading-area

mkdir grading-area

git clone $1 student-submission
echo 'Finished cloning'

# Check existence of ListExamples.java

if ! [[ -f student-submission/ListExamples.java ]]
then
    echo "Missing Necessary Files"
    exit
fi
echo "continue"

cp student-submission/ListExamples.java TestListExamples.java grading-area
cp -r lib grading-area

cd grading-area

javac -cp $CPATH *.java
if [ $? -ne 0 ]
then
    echo "Compilation Error"
    echo "0%"
    exit
fi

java -cp $CPATH org.junit.runner.JUnitCore TestListExamples > Grade.txt

lastline=$(cat Grade.txt | tail -n 2 | head -n 1)
tests=$(echo $lastline | awk -F'[, ]' '{print $3}')
failures=$(echo $lastline | awk -F'[, ]' '{print $6}')
successes=$((tests - failures))

echo "Your score is $successes / $tests"

# Draw a picture/take notes on the directory structure that's set up after
# getting to this point

# Then, add here code to compile and run, and do any post-processing of the
# tests
