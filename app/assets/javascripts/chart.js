var monthNames = [ "January", "February", "March", "April", "May", "June", 
                       "July", "August", "September", "October", "November", "December" ];
    
/**
 * converts a String containing a DateTime representatio into a DateTime object
 * @param {String} dateTimeString 
 * @return {Date} of passed String
 */
function parseString2DateTime(dateTimeString){
	
    var reggie = /(\d{4})-(\d{2})-(\d{2})T(\d{2}):(\d{2}):(\d{2})Z/;
	var dateArray = reggie.exec(dateTimeString); 
	return new Date(
					    (+dateArray[1]),
					    (+dateArray[2])-1, // Careful, month starts at 0!
					    (+dateArray[3]),
					    (+dateArray[4]),
					    (+dateArray[5]),
					    (+dateArray[6])
					);
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
 * draws a line chart of data at defined positionTag with title and subtitle
 * @param {Object} data
 * @param {Object} postionTag
 * @param {Object} title
 * @param {Object} subtitle
 */
function lineChart(data, postionTag, xAxisLable, yAxisLable, typeOfComparedObjects, title, subtitle){
	
	console.log(data);
	
	var lableYEAR  = 'year';
	var lableMONTH = 'month';
	
	var times = new Array();
	var series = new Array();
	var structuredData = new Array();
	
	// create array {'2012-02-01 10:38:01'=> 0, ...} from x = {'2012-02-01 10:38:01', ...} and y = { 0, ...}
	$.map(data, function( item, i){	
		var assocData = new Array();
		item.x.forEach(function(element, index, array){
			item.x[index]=parseString2DateTime(element);
			assocData[item.x[index]]=item.y[index];
		});
		structuredData[item.name]=assocData;
	});
	
	console.log(structuredData);
	
	// join all timestamps into one array
	$.map(data, function( item, i){	
		times = times.concat(item.x);
	});

	console.log(times);
	
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
		
	console.log('max: '+ maxDate);
	console.log('min: '+ minDate);
	console.log('maxYear: '+ maxYear);
	console.log('minYear: '+ minYear);
	console.log('maxMonth: '+ maxMonth);
	console.log('minMonth: '+ minMonth);
	
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
			
			console.log("tempYear: " + tempYear);
			console.log("minYear: " + minYear);
			console.log("maxYear: " + maxYear);
	
			
			if(tempYear==minYear) i = minMonth;
			else if(tempYear==maxYear) maximumMonthNumber = maxMonth;
			else i = 1
			
			while(i<=maximumMonthNumber)tempMonths.push(i++);
					
			xVals.push({year : tempYear,
						month: tempMonths});
						
			tempYear++;			
		}
	}else{
		var tempMon = minMonth+1;
		var tempMonths = new Array();
		
		while(tempMon<=maxMonth)tempMonths.push(tempMon++);
			
		xVals.push({year : minYear,
					month: tempMonths});	
	}
	
	console.log("multi: " + multipleYears);
	
	console.log(xVals);
	
	// fill categories-Array (x-axis)
	// and series-object (values)
	var categories= new Array();
	//var series = Array();
	var seriesByLang = new Array();
	
	$.map(data, function(item, i){
					
		seriesByLang[item.name] = Array ();
	});
	
	console.log(seriesByLang);
	
	xVals.forEach(function(element, index, array){
	
		element[lableMONTH].forEach(function(e, i, a){
			
			var xMonth = e; 
			var xYear  = element[lableYEAR];
			console.log(element);
			console.log(lableYEAR);
			console.log("xYear: " + xYear);
			
			var currSeriesTotal;		// total count of results of a month (doesn't matter if result is success or not')
			var currSeriesPositiv;		// to count success
			var currSeriesNegativ;		// to count fails
			var currNameValues;
			
			// values
			$.map(data, function(value, j){
				
				console.log(value);
				// reset values for each dataset
				currSeriesTotal = 0;
				currSeriesPositiv = 0;		
				currSeriesNegativ = 0;		
	
				value.x.forEach(function(xElement, xIndex, xArray){	
					
					var currXMonth = xElement.getMonth() + 1;	//+1 to match xMonth 1..12, because getMonth() returns a value between 0 and 11
					var currXYear  = xElement.getFullYear();
					
					if(currXMonth==xMonth && currXYear==xYear){
						
						 currSeriesTotal++;
						 if(value.y[xIndex]==0) currSeriesPositiv++;
						 else if(value.y[xIndex]==1) currSeriesNegativ++;
					}
					// console.log("--------------------------------");
					// console.log(value.name + " name");
					// console.log(currXMonth + " currXMonth");
					// console.log(xMonth  + " xMonth");
					// console.log(currXYear + " currXYear");
					// console.log(xYear +" xYear");
					// console.log(currSeriesTotal + " currSeriesTotal");
					
				});
				
				// determine success-rate and add result to 
				//seriesByLang[value.name].push(currSeriesPositiv);
				seriesByLang[value.name].push({
												total: currSeriesTotal,
												success: currSeriesPositiv,
												fail: 	currSeriesNegativ,
												successrate: (currSeriesTotal==0)?0.0:currSeriesPositiv*100.0/currSeriesTotal
											});
			});

			// categories
			categories.push(monthNames[xMonth-1].substring(0,3) + " " + xYear.toString().substring(2));		// -1 to match monthNames array 0..11, because xMonth 1..12
		});
	});
	 console.log(categories); 
	 console.log(seriesByLang); 
	
	$.map(data, function(element, index){
		
		var total       = new Array();
		var success     = new Array();
		var fail        = new Array();
		var successrate = new Array(); 
		
		seriesByLang[element.name].forEach(function(element, index, array){
			
			total.push(element.total);
			success.push(element.success);
			fail.push(element.fail);
			successrate.push(element.successrate);
			
		});
		
		series.push({
						name: element.name,
						data: successrate,
						success: success,
						fail:    fail,
						total:   total
					});
	});
	
	var outseries = series;
	
	console.log(outseries);
	
	function getSingleSeriesByName(name, array){
		
		var retObj = new Object;
		
		array.forEach(function(element, index, arr){
			if(element.name==name)retObj=element;
		});
		
		return retObj;
	}
// 	
	console.log(getSingleSeriesByName('ruby', series));
	
	
    var chart;
    
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



