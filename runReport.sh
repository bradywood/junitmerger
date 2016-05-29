#!/bin/bash -e

  pushd /testSuites/

  listOfXmlJunitFiles=$(find . -name "TEST*.xml" | xargs)

  echo "about to run merge junit_results over list of files"
  echo "list of files: $listOfXmlJunitFiles"
  python /merge_junit_results.py $listOfXmlJunitFiles > /testSuites/combinedJunitXml.xml

  chmod 777 /testSuites/combinedJunitXml.xml

  java -jar /tmp/saxon9he.jar /testSuites/combinedJunitXml.xml /nicelyFormattedJunit.xsl > /testSuites/combinedJunitSummary.txt
  chmod 777 /combinedJunitSummary.txt

  sleep 5;
  popd
