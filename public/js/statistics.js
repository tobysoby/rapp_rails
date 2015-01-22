/*function highchart (speeds, distances, paces, place) {
    //console.log(data);
    $(place).highcharts({
        title: {
            text: 'Statistics',
            x: -20 //center
        },
        xAxis: {
            //categories: speeds[1]
        },
        yAxis: [{
            title: {
                text: ''
            },
            plotLines: [{
                value: 0,
                width: 1,
                color: '#808080'
            }],
            labels: {
                format: '{value} km',
                style: {
                    color: Highcharts.getOptions().colors[0]
                }
            }
        },
            { // Secondary yAxis
            title: {
                text: 'Pace',
                style: {
                    color: Highcharts.getOptions().colors[0]
                }
            },
            labels: {
                format: '{value} min/km',
                style: {
                    color: Highcharts.getOptions().colors[0]
                }
            },
            opposite: true
        }],
        tooltip: {
            valueSuffix: ' km/h'
        },
        legend: {
            layout: 'vertical',
            align: 'right',
            verticalAlign: 'middle',
            borderWidth: 0
        },
        series: [{
            name: 'Speed',
            color: '#0066FF',
            data: speeds,//[0],
        },
                 {
            name: 'Distances',
            data: distances,//[0]
        },
                 {
            name: 'Pace',
            data: paces,//[0],
            yAxis: 1
        }]
    });
}*/

function highchart (benennung, values, place, dates) {
    switch(benennung) {
        case "pace":
            titel = "Average Pace";
            einheit = "min/km"
            break;
        case "distance":
            titel = "Average Distances"
            einheit = "km"
            break;
        case "speed":
            titel = "Average Speeds"
            einheit = "km/h"
            break;
    }

    dates = dates.replace("&quot;", "")
    dates = dates.split(',')
    console.log(dates)

    //console.log(data);
    $(place).highcharts({
        title: {
            text: titel,
            x: -20 //center
        },
        xAxis: {
            categories: dates
        },
        yAxis: [{
            title: {
                text: ''
            },
            plotLines: [{
                value: 0,
                width: 1,
                color: '#808080'
            }],
            labels: {
                format: '{value} ' + einheit,
                style: {
                    color: Highcharts.getOptions().colors[0]
                }
            }
        }],
        tooltip: {
            valueSuffix: ' ' + einheit
        },
        legend: {
            layout: 'vertical',
            align: 'right',
            verticalAlign: 'middle',
            borderWidth: 0
        },
        series: [{
            name: benennung,
            color: '#0066FF',
            data: values,//[0],
        }]
    });
}

function devideData (data_ges) {
    var data = new Array;
    var data_werte = new Array;
    var data_bezeichnungen = new Array;
    for (var i=0; i<data_ges.length; i++) {
        data_werte.push(parseFloat(data_ges[i][1]));
        data_bezeichnungen.push(data_ges[i][0]);
    }
    data.push(data_werte);
    data.push(data_bezeichnungen);
    return data;
}

