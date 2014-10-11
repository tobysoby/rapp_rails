/*function drawChart (data, place) {
    var dataset = data[0];
    var data_bez = data[1];

    //Width and height
    var w = 1000;
    var h = 100;
    var barPadding = 1;
			
    //Create SVG element
    var svg = d3.select(place)
        .append("svg")
        .attr("width", w)
        .attr("height", h);

    svg.selectAll("rect")
        .data(dataset)
        .enter()
        .append("rect")
        .attr("x", function(d, i) {
            return i * (w / dataset.length);
        })
        .attr("y", function(d) {
            return h - (d * 4);
        })
        .attr("width", w / dataset.length - barPadding)
        .attr("height", function(d) {
            return d * 4;
        });
			
    svg.selectAll("text")
        .data(data_bez)
        .enter()
        .append("text")
        .text(function(d) {
        return d;
        })
        .attr("text-anchor", "middle")
        .attr("x", function(d, i) {
            return i * (w / dataset.length) + (w / dataset.length - barPadding) / 2;
        })
        .attr("y", 95)
        .attr("font-family", "sans-serif")
        .attr("font-size", "11px")
        .attr("fill", "#C5D5D9");
}

function drawChartLine (data, place) {
    var dataset = data[0];
    var data_bez = data[1];
    // implementation heavily influenced by http://bl.ocks.org/1166403 
		
		// define dimensions of graph
		var m = [80, 80, 80, 80]; // margins
    var w = 1000;
    var h = 100;
		
		// create a simple data array that we'll plot with a line (this array represents only the Y values, X will just be the index location)
		//var data = [3, 6, 2, 7, 5, 2, 0, 3, 8, 9, 2, 5, 9, 3, 6, 3, 6, 2, 7, 5, 2, 1, 3, 8, 9, 2, 5, 9, 2, 7];

		// X scale will fit all values from data[] within pixels 0-w
		var x = d3.scale.linear().domain([0, dataset.length]).range([0, w]);
		// Y scale will fit values from 0-10 within pixels h-0 (Note the inverted domain for the y-scale: bigger is up!)
		//var y = d3.scale.linear().domain([0, 10]).range([h, 0]);
			// automatically determining max range can work something like this
			var y = d3.scale.linear().domain([0, d3.max(dataset)]).range([h, 0]);

		// create a line function that can convert data[] into x and y points
		var line = d3.svg.line()
			// assign the X function to plot our line as we wish
			.x(function(d,i) { 
				// verbose logging to show what's actually being done
				console.log('Plotting X value for data point: ' + d + ' using index: ' + i + ' to be at: ' + x(i) + ' using our xScale.');
				// return the X coordinate where we want to plot this datapoint
				return x(i); 
			})
			.y(function(d) { 
				// verbose logging to show what's actually being done
				console.log('Plotting Y value for data point: ' + d + ' to be at: ' + y(d) + " using our yScale.");
				// return the Y coordinate where we want to plot this datapoint
				return y(d); 
			})

			// Add an SVG element with the desired dimensions and margin.
			var graph = d3.select(place).append("svg:svg")
			      .attr("width", w + m[1] + m[3])
			      .attr("height", h + m[0] + m[2])
			    .append("svg:g")
			      .attr("transform", "translate(" + m[3] + "," + m[0] + ")");

			// create yAxis
			var xAxis = d3.svg.axis().scale(x).tickSize(-h).tickSubdivide(true);
			// Add the x-axis.
			graph.append("svg:g")
			      .attr("class", "x axis")
			      .attr("transform", "translate(0," + h + ")")
			      .call(xAxis);


			// create left yAxis
			var yAxisLeft = d3.svg.axis().scale(y).ticks(4).orient("left");
			// Add the y-axis to the left
			graph.append("svg:g")
			      .attr("class", "y axis")
			      .attr("transform", "translate(-25,0)")
			      .call(yAxisLeft);
    
    graph.selectAll("text")
        .data(data_bez)
        .enter()
        .append("text")
        .text(function(d) {
        return d;
        })
        .attr("text-anchor", "middle")
        .attr("x", function(d, i) {
            return i * (w / dataset.length) + (w / dataset.length - barPadding) / 2;
        })
        .attr("y", 95)
        .attr("font-family", "sans-serif")
        .attr("font-size", "11px")
        .attr("fill", "#C5D5D9");
    
  			// Add the line by appending an svg:path element with the data line we created above
			// do this AFTER the axes above so that the line is above the tick-lines
  			graph.append("svg:path").attr("d", line(dataset));
}*/

function highchart (speeds, distances, paces, place) {
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
            name: 'Average Speed',
            color: '#0066FF',
            data: speeds,//[0],
        },
                 {
            name: 'Distances',
            data: distances,//[0]
        },
                 {
            name: 'Average Pace',
            data: paces,//[0],
            yAxis: 1
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
