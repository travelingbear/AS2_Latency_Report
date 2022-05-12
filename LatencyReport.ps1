#CheckLatency.ps1

#This powershell script uses the excellent TCPING.EXE (https://elifulkerson.com/projects/tcping.php) 
#to send probes using TCP on port 443 to the AppStream endpoints and calculate which endpoint is better
#according to the public documentation here: https://docs.aws.amazon.com/appstream2/latest/developerguide/bandwidth-recommendations-user-connections.html
#
#It generates a text and an HTML file in the folder it's located.


#Creates an HTML file for better view

echo "<html>" > Latency_Report_$(get-date -f yy-MM-dd).html
echo "<head><style>table, th, td {border:1px solid black;padding: 6px;}</style></head>" > Latency_Report_$(get-date -f yy-MM-dd).html
echo "<title>Latency Report</title>" >> Latency_Report_$(get-date -f yy-MM-dd).html
echo "<body>" >> Latency_Report_$(get-date -f yy-MM-dd).html
echo "<table><thread>" >> Latency_Report_$(get-date -f yy-MM-dd).html
echo "<tr>" >> Latency_Report_$(get-date -f yy-MM-dd).html
echo "<th>Endpoint</th>" >> Latency_Report_$(get-date -f yy-MM-dd).html
echo "<th>Latency</th>" >> Latency_Report_$(get-date -f yy-MM-dd).html
echo "<th>Rating</th>" >> Latency_Report_$(get-date -f yy-MM-dd).html
echo "<th>Recommendation</th>" >> Latency_Report_$(get-date -f yy-MM-dd).html
echo "</tr>" >> Latency_Report_$(get-date -f yy-MM-dd).html
echo "</trhead>" >> Latency_Report_$(get-date -f yy-MM-dd).html
echo "<tbody>" >> Latency_Report_$(get-date -f yy-MM-dd).html

echo "Generating report. This may take some minutes..."

#Start reading the endpoints and FOREACH endpoint, it will 'tcping' it > extract the average > output to Latency_Report(date).txt and Latency_Report(date).html

Get-Content .\endpoints.txt | foreach {

#html
echo "<tr><td>$_</td>" >> Latency_Report_$(get-date -f yy-MM-dd).html
#txt
echo "`n## Probing latency for $_ ##";.\tcping.exe $_ 443; 

#gets the result > split to find the average > format the average to get the value
$average = (.\tcping.exe $_ 443 | findstr Average).Split(",")| Select-String -Pattern '\bAverage = ' | ConvertFrom-StringData | Select -ExpandProperty Values

##Creates the suggestions based on the AVERAGE for each endpoint

#If less then 150ms but bigger then 100ms
if ( ([Int]$average.Replace("ms","") -lt 150) -and ([Int]$average.Replace("ms","") -gt 100) ) {

    #txt
	echo "`n`n##################################################`n`n  Latency is ACCEPTABLE - Recommended Workload: Line of business applications  `n`n##################################################`n`n"
	
    #html
    echo "<td style='background-color: lightyellow;'>$average</td>" >> Latency_Report_$(get-date -f yy-MM-dd).html
	echo "<td style='background-color: lightyellow;'>ACCEPTABLE</td>" >> Latency_Report_$(get-date -f yy-MM-dd).html
	echo "<td>Line of business applications</td>" >> Latency_Report_$(get-date -f yy-MM-dd).html
	
} 

#If less then 100ms but greater then 50ms
elseif ( ([Int]$average.Replace("ms","") -lt 100) -and ([Int]$average.Replace("ms","") -gt 50) ) {
	
    echo "`n`n##################################################`n`n  Latency is GOOD - Recommended Workload: Graphics applications  `n`n##################################################`n`n"
	
    #html
    echo "<td style='background-color: lightgreen;'>$average</td>" >> Latency_Report_$(get-date -f yy-MM-dd).html
	echo "<td style='background-color: lightgreen;'>GOOD</td>" >> Latency_Report_$(get-date -f yy-MM-dd).html
	echo "<td>Graphics applications</td>" >> Latency_Report_$(get-date -f yy-MM-dd).html
	
} 

#If less then 50ms but greater then 0ms
elseif ([Int]$average.Replace("ms","") -lt 50 -and ([Int]$average.Replace("ms","") -gt 0) ) {
	
    echo "`n`n##################################################`n`n  Latency is EXCELLENT - Recommended Workload: High fidelity applications  `n`n##################################################`n`n"
	
    #html
    echo "<td style='background-color: lightgreen;'>$average</td>" >> Latency_Report_$(get-date -f yy-MM-dd).html
	echo "<td style='background-color: lightgreen;'>EXCELLENT</td>" >> Latency_Report_$(get-date -f yy-MM-dd).html
	echo "<td>High fidelity applications</td>" >> Latency_Report_$(get-date -f yy-MM-dd).html
	
} else {
	
    echo "`n`n##################################################`n`n  Latency is POOR - $_ may not be the best endpoint to connect from this location  `n`n##################################################`n`n"
	
    #html
    echo "<td style='background-color: pink;'>$average</td>" >> Latency_Report_$(get-date -f yy-MM-dd).html
	echo "<td style='background-color: pink;'>POOR</td>" >> Latency_Report_$(get-date -f yy-MM-dd).html
	echo "<td>Not recommended from this location</td>" >> Latency_Report_$(get-date -f yy-MM-dd).html
}

##closes the report for this region

#txt
echo "`n----------------------------------------------------------------`n"

#html
echo "</tr>" >> Latency_Report_$(get-date -f yy-MM-dd).html
} | Out-File .\Latency_Report_$(get-date -f yy-MM-dd).txt -Append #save the output of the command to the TXT file

#Closes the HTML file
echo '</tbody></table></body></html>' >> Latency_Report_$(get-date -f yy-MM-dd).html

$html_report=$(pwd | select -ExpandProperty Path)+"\Latency_Report_$(get-date -f yy-MM-dd).html"
$txt_report=$(pwd | select -ExpandProperty Path)+"\Latency_Report_$(get-date -f yy-MM-dd).txt"

if ( (Test-Path -Path $html_report) -and (Test-Path -Path $txt_report) ) {
	echo "`nI have finished generating the reports as:`n"
	echo "- $html_report"
	echo "- $txt_report `n"
} else {
	echo "There was a problem generating the reports."	
}
