var monthNames = [ "January", "February", "March", "April", "May", "June", 
                       "July", "August", "September", "October", "November", "December" ];
 

var CHARTTYPE_COLUMN = 'column';
var CHARTTYPE_SPLINECOLUMN = 'splinecolumn';
var CHARTTYPE_LINE   = 'line';

var CHARTLABEL_SUCCESS = 'success';
var CHARTLABEL_FAIL    = 'fail';

/**
 * converts a String containing a DateTime representatio into a DateTime object
 * @param {String} dateTimeString 
 * @return {Date} of passed String
 */
function parseString2DateTime(dateTimeString){
	
    var reggie = /(\d{4})-(\d{2})-(\d{2})T(\d{2}):(\d{2}):(\d{2})Z/;
	var dateArray = reggie.exec(dateTimeString); 

	try{

		var d = new Date(
						    (+dateArray[1]),
						    (+dateArray[2])-1, // Careful, month starts at 0!
						    (+dateArray[3]),
						    (+dateArray[4]),
						    (+dateArray[5]),
						    (+dateArray[6])
						);
		if(d.getFullYear() < 2010){
			return -1;
		}else{
			return d;
		}

	}catch(e){

		console.log('invalid dataTime: '+dateTimeString);
		return -1;
	}
}
/**
 * extend Date to return name of a month of a string
 */
Date.prototype.getMonthName = function() {
	return monthNames[this.getMonth()];
}

/**
 * sorts by date ascending
 * @param a {Date} first date to compare
 * @param b {Date} second date to compare  
 * @return {int} representing in what relation a and b are in
 * 				 less than 0: Sort "a" to be a lower index than "b"
 * 				 zero: "a" and "b" should be considered equal, and no sorting performed.
 * 				 greater than 0: Sort "b" to be a lower index than "a".
 */	
function SortByDateASC(a, b){
	return (a - b); // a and b are interpreted as milliseconds since 1970, therefore a simple subtraction in sufficent
}

/**
 * draws a splinecolumn chart of data at defined positionTag with title and subtitle
 * @param {Object} data
 * @param {Object} postionTag
 * @param {Object} xAxisLable
 * @param {Object} yAxisLable
 * @param {Object} typeOfComparedObjects
 * @param {Object} title
 * @param {Object} subtitle
 * @param {Object} yAxisOppositeLable
 */
function columnSplineChart(data, postionTag, xAxisLable, yAxisLable, typeOfComparedObjects, title, subtitle, yAxisOppositeLable){

	customChart(CHARTTYPE_SPLINECOLUMN, data, postionTag, xAxisLable, yAxisLable, typeOfComparedObjects, title, subtitle, yAxisOppositeLable);
}

/**
 * draws a column chart of data at defined positionTag with title and subtitle
 * @param {Object} data
 * @param {Object} postionTag
 * @param {Object} xAxisLable
 * @param {Object} yAxisLable
 * @param {Object} typeOfComparedObjects
 * @param {Object} title
 * @param {Object} subtitle
 * @param {Object} yAxisOppositeLable
 */
function columnChart(data, postionTag, xAxisLable, yAxisLable, typeOfComparedObjects, title, subtitle){

	customChart(CHARTTYPE_COLUMN, data, postionTag, xAxisLable, yAxisLable, typeOfComparedObjects, title, subtitle);
}

/**
 * draws a line chart of data at defined positionTag with title and subtitle
 * @param {Object} data
 * @param {Object} postionTag
 * @param {Object} xAxisLable
 * @param {Object} yAxisLable
 * @param {Object} typeOfComparedObjects
 * @param {Object} title
 * @param {Object} subtitle
 * @param {Object} yAxisOppositeLable
 */
function lineChart(data, postionTag, xAxisLable, yAxisLable, typeOfComparedObjects, title, subtitle){

	customChart(CHARTTYPE_LINE, data, postionTag, xAxisLable, yAxisLable, typeOfComparedObjects, title, subtitle);
}

/**
 * draws a specified chart of data at defined positionTag with title and subtitle
 * @param {Object} data
 * @param {Object} postionTag
 * @param {Object} title
 * @param {Object} subtitle
 */
function customChart(chartType, data, postionTag, xAxisLable, yAxisLable, typeOfComparedObjects, title, subtitle, yAxisOppositeLable){
	
	// console.log(data);
	var invalidDates = 0;
	
	var lableYEAR  = 'year';
	var lableMONTH = 'month';
	
	var times = new Array();
	var series = new Array();
	var structuredData = new Array();
	
	// create array {'2012-02-01T10:38:01Z'=> 0, ...} from x = {'2012-02-01T10:38:01Z', ...} and y = { 0, ...}
	$.map(data, function( item, i){	
		var assocData = new Array();
		item.x.forEach(function(element, index, array){
			var currDate = parseString2DateTime(element);
			if(currDate == -1){
				// in case it was an invalid date, remove it both from date and value arrays
				item.x = item.x.slice(0,index-1).concat(item.x.slice(index));
				item.y = item.y.slice(0,index-1).concat(item.y.slice(index));
				console.log('element removed at index: ' + index);
			}else{
				item.x[index]= currDate;
				assocData[item.x[index]]=item.y[index];
			}
		});
		structuredData[item.name]=assocData;
	});
	
	// console.log(structuredData);
	
	// join all timestamps into one array
	$.map(data, function( item, i){	
		times = times.concat(item.x);
	});

	// console.log(times);
	
	// get max and min date form all times
	var maxDate = new Date(times.max());
	var minDate = new Date(times.min());
	// get year of max and min to evaluate x-axis description later
	var maxYear = maxDate.getFullYear();
	var minYear = minDate.getFullYear();
	// get month of max and min to evaluate x-axis description later
	var maxMonth = maxDate.getMonth()+1;
	var minMonth = minDate.getMonth()+1;
	
	var multipleYears = (maxYear != minYear);
		
	// console.log('max: '+ maxDate);
	// console.log('min: '+ minDate);
	console.log('maxYear: '+ maxYear);
	console.log('minYear: '+ minYear);
	// console.log('maxMonth: '+ maxMonth);
	// console.log('minMonth: '+ minMonth);
	
	var xVals = new Array();
	var yVals = new Array();
	
	// setup objects of structure
	// val = {
	// 			year : 2012,
	//			month : [1, 2, 3, 4]
	//		 }
	if(multipleYears){
		var tempYear = minYear
		while(tempYear <= maxYear){
			
			var i = 1;					 // represents January
			var maximumMonthNumber = 12; // represents Dercember
			
			var tempMonths = new Array();// contains relevant month of current year
			
			// console.log("tempYear: " + tempYear);
			// console.log("minYear: " + minYear);
			// console.log("maxYear: " + maxYear);
	
			
			if(tempYear==minYear) i = minMonth;
			else if(tempYear==maxYear) maximumMonthNumber = maxMonth;
			else i = 1
			
			while(i<=maximumMonthNumber)tempMonths.push(i++);
					
			xVals.push({year : tempYear,
						month: tempMonths});
						
			tempYear++;			
		}
	}else{
		var tempMon = minMonth;
		var tempMonths = new Array();
		
		while(tempMon<=maxMonth)tempMonths.push(tempMon++);
			
		xVals.push({year : minYear,
					month: tempMonths});	
	}
	
	// console.log("multi: " + multipleYears);
	
	// console.log('xVals');
	// console.log(xVals);
	
	// fill categories-Array (x-axis)
	// and series-object (values)
	var categories= new Array();
	//var series = Array();
	var seriesByLang = new Array();
	
	$.map(data, function(item, i){
					
		seriesByLang[item.name] = Array ();
	});
	
	// console.log(seriesByLang);
	
	xVals.forEach(function(element, index, array){
	
		element[lableMONTH].forEach(function(e, i, a){
			
			var xMonth = e; 
			var xYear  = element[lableYEAR];
			// console.log(element);
			// console.log(lableYEAR);
			// console.log("xYear: " + xYear);
			
			var currSeriesTotal;		// total count of results of a month (doesn't matter if result is success or not')
			var currSeriesPositiv;		// to count success
			var currSeriesNegativ;		// to count fails
			var currNameValues;
			
			// values
			$.map(data, function(value, j){
				
				// console.log(value);
				// reset values for each dataset
				currSeriesTotal = 0;
				currSeriesPositiv = 0;		
				currSeriesNegativ = 0;		
	
				value.x.forEach(function(xElement, xIndex, xArray){	
					
					try{

						var currXMonth = xElement.getMonth() + 1;	//+1 to match xMonth 1..12, because getMonth() returns a value between 0 and 11
						var currXYear  = xElement.getFullYear();
						
						if(currXMonth==xMonth && currXYear==xYear){
							
							 currSeriesTotal++;
							 if(value.y[xIndex]==1) currSeriesPositiv++;
							 else if(value.y[xIndex]==0) currSeriesNegativ++;
						}
						// console.log("--------------------------------");
						// console.log(value.name + " name");
						// console.log(currXMonth + " currXMonth");
						// console.log(xMonth  + " xMonth");
						// console.log(currXYear + " currXYear");
						// console.log(xYear +" xYear");
						// console.log(currSeriesTotal + " currSeriesTotal");
					}catch(exception){
						invalidDates++;
						// console.log('EXC ' + exception.toString());
						// console.log('null at index: ' + xIndex);
					}
				});
				
				// if (currSeriesTotal==0) {
				// 	console.log("jetzt 0!!");
				// 	currSeriesTotal = null;

				// }

				// determine success-rate and add result to 
				//seriesByLang[value.name].push(currSeriesPositiv);
				//if(chartType == CHARTTYPE_LINE){
				//	console.log("chartType "+CHARTTYPE_LINE);
					seriesByLang[value.name].push({
													total:   currSeriesTotal,
													success: currSeriesPositiv,
													fail: 	 currSeriesNegativ,
													successrate: (currSeriesTotal==0)?0.0:currSeriesPositiv*100.0/currSeriesTotal
												});
				// }else if (chartType == CHARTTYPE_COLUMN){
				// 	console.log("chartType "+CHARTTYPE_COLUMN);
				// 	var successIndex = 0;
				// 	var failIndex = 0;
				// 	$.map(data, function( item, i){	
						
				// 		if(item.name == CHARTLABEL_FAIL)failIndex = i;
				// 		if(item.name == CHARTLABEL_SUCCESS)successIndex = i;
				// 	});			
				// 	var failTotal = data[failIndex].x.length;
				// 	var successTotal = data[successIndex].x.length;
				// 	var successFailTotal = failTotal+successTotal;

				// 	if(value.name == CHARTLABEL_SUCCESS){
				// 		seriesByLang[value.name].push({
				// 										total:   successFailTotal,
				// 										success: successTotal,
				// 										fail: 	 failTotal,
				// 										successrate: (successFailTotal==0)?0.0:successTotal*100.0/successFailTotal
				// 									});

				// 	}else if(value.name == CHARTLABEL_FAIL){
				// 		seriesByLang[value.name].push({
				// 										total:   successFailTotal,
				// 										success: successTotal,
				// 										fail: 	 failTotal,
				// 										successrate: (successFailTotal==0)?0.0:failTotal*100.0/successFailTotal
				// 									});
				// 	}
				// }

			});

			// categories
			categories.push(monthNames[xMonth-1].substring(0,3) + " " + xYear.toString().substring(2));		// -1 to match monthNames array 0..11, because xMonth 1..12
		});
	});
	 // console.log(categories); 
	 // console.log(seriesByLang); 
	
	if(chartType == CHARTTYPE_COLUMN || chartType == CHARTTYPE_SPLINECOLUMN){
		
		seriesByLang[CHARTLABEL_SUCCESS].forEach(function(element, index, array){
				
			var failCount = seriesByLang[CHARTLABEL_FAIL][index].success;
			var successCount = element.success;
			var successFailTotal = failCount+successCount;

			seriesByLang[CHARTLABEL_SUCCESS][index].total       = successFailTotal;
			seriesByLang[CHARTLABEL_SUCCESS][index].fail        = failCount;
			seriesByLang[CHARTLABEL_SUCCESS][index].success     = successCount;
			seriesByLang[CHARTLABEL_SUCCESS][index].successrate = (successFailTotal==0)?0.0:successCount*100.0/successFailTotal;;

			seriesByLang[CHARTLABEL_FAIL][index].total       = successFailTotal;
			seriesByLang[CHARTLABEL_FAIL][index].fail        = failCount;
			seriesByLang[CHARTLABEL_FAIL][index].success     = successCount;
			seriesByLang[CHARTLABEL_FAIL][index].successrate = (successFailTotal==0)?0.0:failCount*100.0/successFailTotal;

		});			
	}

	$.map(data, function(element, index){
		
		var total       = new Array();
		var success     = new Array();
		var fail        = new Array();
		var successrate = new Array(); 

		seriesByLang[element.name].forEach(function(element, index, array){
			
			//just push data if there were jobs for language in this month
			if (element.total > 0) {
				total.push(element.total);
				success.push(element.success);
				fail.push(element.fail);
				successrate.push(Math.round(element.successrate));
			}
			
		});
		
		series.push({
						name: element.name,
						data: successrate,
						success: success,
						fail:    fail,
						total:   total
					});
	});

	if(invalidDates>0){
		alert('Sourcedata contains ' + invalidDates + ' invalid DateTime-values!');
	}

	console.log(chartType);
console.log(series);


    var chart;
    switch(chartType){
   	case CHARTTYPE_LINE:
    	chart = drawLineChart(categories, series, getSingleSeriesByName, postionTag, xAxisLable, yAxisLable, typeOfComparedObjects, title, subtitle);
    	break;
    case CHARTTYPE_COLUMN:
    	chart = drawColumnChart(categories, series, getSingleSeriesByName, postionTag, xAxisLable, yAxisLable, typeOfComparedObjects, title, subtitle);
    	break;
    case CHARTTYPE_SPLINECOLUMN:
    	chart = drawColumSplineChart(categories, series, getSingleSeriesByName, postionTag, xAxisLable, yAxisLable, typeOfComparedObjects, title, subtitle, yAxisOppositeLable);
    	break;
    default:
    	postionTag.html('Unknown chart-type "' + chartType + '"! <br />Please use var "CHARTTYPE_COLUMN", "CHARTTYPE_SPLINECOLUMN", "CHARTTYPE_LINE".');
	}
}


function getSingleSeriesByName(name, array){
	
	var retObj = new Object;
	
	array.forEach(function(element, index, arr){
		if(element.name==name)retObj=element;
	});
	
	return retObj;
}

function drawColumSplineChart(categories, series, getSingleSeriesByName, postionTag, xAxisLable, yAxisLable, typeOfComparedObjects, title, subtitle, yAxisOppositeLable){

		var splineType = "spline";    
		series[0].type  = 'column';
		series[1].type  = 'column';
	
		series.push({
			data: series[0].total,
			type: splineType,
			name: typeOfComparedObjects + "s in total",
			yAxis: 1
		});

		chart = new Highcharts.Chart({
            chart: {
                renderTo: postionTag,
                marginRight: 165,
                marginBottom: 45
            },
            title: {
                text: title,
                x: -20 //center
            },
            subtitle: {
                text: subtitle,
                x: -20
            },
            xAxis: {
                title: {
                    text: xAxisLable
                },
                categories: categories
            },
            yAxis: [{
            	min: 0,
            	max: 100,
                title: {
                    text: yAxisLable
                },
                plotLines: [{
                    value: 0,
                    width: 1,
                    color: '#808080'
                }]
            },{ // Secondary yAxis
            	min: 0,
            	max: series[2].data.max(),
                title: {
                    text: (yAxisOppositeLable == null)? "Number of " + typeOfComparedObjects.capitalize() + "s" : yAxisOppositeLable,
                    style: {
                        color: '#4572A7'
                    }
                },
                labels: {
                    formatter: function() {
                        return this.value;
                    },
                    style: {
                        color: '#4572A7'
                    }
                },
                opposite: true
            }],
            tooltip: {
            	
                formatter: function() {
                		if(this.series.type==splineType){
                			return '<b>'+ this.y +' ' + typeOfComparedObjects + 's in total</b>';
                		}else{
	                        return '<b>'+ this.series.name +'</b><br />'+
	                        this.x +': '+ this.y+'%<br />'+
	                        getSingleSeriesByName(this.series.name, series).success[categories.indexOf(this.x)] +' succeeded and <br />' +
	                        getSingleSeriesByName(this.series.name, series).fail[categories.indexOf(this.x)] + ' failed of <br />' + 
	                        getSingleSeriesByName(this.series.name, series).total[categories.indexOf(this.x)] + ' ' + typeOfComparedObjects + 's in total';
                   		}
                }
            },
            legend: {
                layout: 'vertical',
                align: 'right',
                verticalAlign: 'top',
                x: -10,
                y: 100,
                borderWidth: 0
            },
            series: series,
            
            colors: [
						'#FF8E8E',
						'#93EEAA', 
						'#4572A7', 
						'#AA4643', 
						'#89A54E', 
						'#80699B', 
						'#3D96AE', 
						'#DB843D', 
						'#92A8CD', 
						'#A47D7C', 
						'#B5CA92'				
					]
        });
}


function drawLineChart(categories, series, getSingleSeriesByName, postionTag, xAxisLable, yAxisLable, typeOfComparedObjects, title, subtitle){
    
        chart = new Highcharts.Chart({
            chart: {
                renderTo: postionTag,
                type: 'line',
                marginRight: 130,
                marginBottom: 45
            },
            title: {
                text: title,
                x: -20 //center
            },
            subtitle: {
                text: subtitle,
                x: -20
            },
            xAxis: {
                title: {
                    text: xAxisLable
                },
                categories: categories
            },
            yAxis: {
            	min: 0,
            	max: 100,
                title: {
                    text: yAxisLable
                },
                plotLines: [{
                    value: 0,
                    width: 1,
                    color: '#808080'
                }]
            },
            tooltip: {
            	
                formatter: function() {
                        return '<b>'+ this.series.name +'</b><br />'+
                        this.x +': '+ this.y+'%<br />'+
                        getSingleSeriesByName(this.series.name, series).success[categories.indexOf(this.x)] +' succeeded and <br />' +
                        getSingleSeriesByName(this.series.name, series).fail[categories.indexOf(this.x)] + ' failed of <br />' + 
                        getSingleSeriesByName(this.series.name, series).total[categories.indexOf(this.x)] + ' ' + typeOfComparedObjects + 's in total';
                }
            },
            legend: {
                layout: 'vertical',
                align: 'right',
                verticalAlign: 'top',
                x: -10,
                y: 100,
                borderWidth: 0
            },
            series: series
        });
}


function drawColumnChart(categories, series, getSingleSeriesByName, postionTag, xAxisLable, yAxisLable, typeOfComparedObjects, title, subtitle){
    
		//console.log(series);


        chart = new Highcharts.Chart({
            chart: {
                renderTo: postionTag,
                type: 'column',
                marginRight: 130,
                marginBottom: 45
            },
            title: {
                text: title,
                x: -20 //center
            },
            subtitle: {
                text: subtitle,
                x: -20
            },
            xAxis: {
                title: {
                    text: xAxisLable
                },
                categories: categories
            },
            yAxis: {
            	min: 0,
            	max: 100,
                title: {
                    text: yAxisLable
                },
                plotLines: [{
                    value: 0,
                    width: 1,
                    color: '#808080'
                }]
            },
            tooltip: {
            	
                formatter: function() {
                        return '<b>'+ this.series.name +'</b><br />'+
                        this.x +': '+ this.y+'%<br />'+
                        getSingleSeriesByName(this.series.name, series).success[categories.indexOf(this.x)] +' succeeded and <br />' +
                        getSingleSeriesByName(this.series.name, series).fail[categories.indexOf(this.x)] + ' failed of <br />' + 
                        getSingleSeriesByName(this.series.name, series).total[categories.indexOf(this.x)] + ' ' + typeOfComparedObjects + 's in total';
                }
            },
            legend: {
                layout: 'vertical',
                align: 'right',
                verticalAlign: 'top',
                x: -10,
                y: 100,
                borderWidth: 0
            },
            series: series,
            
            colors: [
						'#FF8E8E',
						'#93EEAA', 
						'#4572A7', 
						'#AA4643', 
						'#89A54E', 
						'#80699B', 
						'#3D96AE', 
						'#DB843D', 
						'#92A8CD', 
						'#A47D7C', 
						'#B5CA92'				
					]
        });
}

function pieChart(data, container, title, share) {
    var chart;
      
      // Radialize the colors
    Highcharts.getOptions().colors = Highcharts.map(Highcharts.getOptions().colors, function(color) {
        return {
            radialGradient: { cx: 0.5, cy: 0.3, r: 0.7 },
            stops: [
                [0, color],
                [1, Highcharts.Color(color).brighten(-0.3).get('rgb')] // darken
            ]
        };
    });
    
    // Build the chart
        chart = new Highcharts.Chart({
            chart: {
                renderTo: container,
                plotBackgroundColor: null,
                plotBorderWidth: null,
                plotShadow: false
            },
            title: {
                text: title
            },
            tooltip: {
              pointFormat: '{series.name}: <b>{point.percentage}%</b>',
              percentageDecimals: 1
            },
            plotOptions: {
                pie: {
                    allowPointSelect: true,
                    cursor: 'pointer',
                    dataLabels: {
                        enabled: true,
                        color: '#000000',
                        connectorColor: '#000000',
                        formatter: function() {
                            return '<b>'+ this.point.name +'</b>: '+ Math.round(this.percentage*10)/10.0 +' %';
                        }
                    }
                }
            },
            series: [{
                type: 'pie',
                name: share,
                data: data
            }],
            color : ['#FF8E8E',
                      '#93EEAA', 
                      '#4572A7']
        });
}

