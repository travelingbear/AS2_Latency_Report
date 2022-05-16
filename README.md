# AS2 Latency Report

What is?
-------

It's a simple script that generates latency reports for AS2 endpoints

What it does?
--------

This powershell script uses the excellent TCPING.EXE (https://elifulkerson.com/projects/tcping.php) to send probes using TCP on port 443 to the AppStream endpoints and calculate which endpoint is better according to the public documentation here: https://docs.aws.amazon.com/appstream2/latest/developerguide/bandwidth-recommendations-user-connections.html

It generates a text and an HTML file in the folder it's located.

What is included?
----
 - endpoints.txt - This is where the script will look for the endpoints
 - tcping.exe - This is what is used to send TCP probes to the endpoints on port 443
 - LatencyReport.ps1 - The script that generates the files for you

How to use?
-----
1. Download the files to a folder on your computer;
2. Open powershell and navigate to the folder where you downloaded the files (i.e. ```cd C:\temp\AS2Latency\```) - Make SURE you are in the folder where the files are located;
3. Execute LatencyReport.ps1 ```powershell.exe -NoLogo -ExecutionPolicy bypass -NoProfile -File .\LatencyReport.ps1```;
4. Files will be saved in the same folder location as LatencyReport(date).txt and LatencyReport(date).html

*As this is a downloaded script, you may see a security warning before running it*

What is the expected output?
----

If everything goes right, you should see this:
```
Generating report. This may take some minutes...

I have finished generating the reports as:

- D:\Users\MY_USER\Desktop\AppStream\LatencyTest\Latency_Report_22-05-12.html
- D:\Users\MY_USER\Desktop\AppStream\LatencyTest\Latency_Report_22-05-12.txt

```

The text file should look like this:
```
## Probing latency for appstream2.us-east-1.amazonaws.com ##

Probing 52.94.228.236:443/tcp - Port is open - time=69.752ms 
Probing 52.94.228.236:443/tcp - Port is open - time=70.650ms 
Probing 52.94.228.236:443/tcp - Port is open - time=71.492ms 
Probing 52.94.228.236:443/tcp - Port is open - time=70.133ms 

Ping statistics for 52.94.228.236:443
     4 probes sent. 
     4 successful, 0 failed.  (0.00% fail)
Approximate trip times in milli-seconds:
     Minimum = 69.752ms, Maximum = 71.492ms, Average = 70.507ms


##################################################

  Latency is GOOD - Recommended Workload: Graphics applications  

##################################################
```

And the HTML page should look like this:
![ReportsPage](https://dtqryi1d1tj5j.cloudfront.net/AS2LatencyTable.PNG)


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
