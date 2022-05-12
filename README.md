# AS2 Latency Report

What is?
-------

It's a simple script that generates latency reports for AS2 endpoints

What it does?
--------

This powershell script uses the excellent TCPING.EXE (https://elifulkerson.com/projects/tcping.php) to send probes using TCP on port 443 to the AppStream endpoints and calculate which endpoint is better according to the public documentation here: https://docs.aws.amazon.com/appstream2/latest/developerguide/bandwidth-recommendations-user-connections.html

It generates a text and an HTML file in the folder it's located.

How to use?
-----
1. Download the files to a folder on your computer;
2. Open powershell and navigate to the folder where you downloaded the files (i.e. cd C:\temp\AS2Latency\);
3. Execute LatencyReport.ps1;
4. Files will be saved in the same folder location as LatencyReport(date).txt and LatencyReport(date).html

Which regions will it test?
-----
Just the public (non-FIPS and non-GovCloud) regions:

 - appstream2.us-east-1.amazonaws.com
 - appstream2.us-west-2.amazonaws.com
 - appstream2.ap-south-1.amazonaws.com
 - appstream2.ap-northeast-2.amazonaws.com
 - appstream2.ap-southeast-1.amazonaws.com
 - appstream2.ap-southeast-2.amazonaws.com
 - appstream2.ap-northeast-1.amazonaws.com
 - appstream2.ca-central-1.amazonaws.com
 - appstream2.eu-central-1.amazonaws.com
 - appstream2.eu-west-1.amazonaws.com
 - appstream2.eu-west-2.amazonaws.com