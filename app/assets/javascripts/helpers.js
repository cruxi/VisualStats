/**
 * converts a string contianing multi spaces or empty lines 
 * to a plain text representation with single spaces and no 
 * newline breaks
 * @param {String} htmlString string containing multiple spaces and newlines
 * @return {String} plain text 
 */
function multilineTrim(htmlString) {
   // split the string into an array by line separator
   // call $.trim on each line
   // filter out the empty lines
   // join the array of lines back into a string
   return htmlString.split("\n").map($.trim).filter(function(line) { return line != "" }).join(" ");
}


/**
 * extend Date to determine equality
 */
Date.prototype.equals = function(d) {
  return this.getTime() === d.getTime()
}

/**
 * extend Array to determine maximum value
 */
Array.prototype.max = function() {

	try{
		return Math.max.apply(null, this);
	}catch(e){
		var len = this.length;
		var max1 = this.slice(len/2).max();
		var max2 = this.slice(0,len/2).max();
		return (max1>max2)?max1:max2;
	}
}


/**
 * extend Array to determine minimum value
 */
Array.prototype.min = function() {
  
  	try{
		return Math.min.apply(null, this);
	}catch(e){
		var len = this.length;
		var min1 = this.slice(len/2).min();
		var min2 = this.slice(0,len/2).min();
		return (min1<min2)?min1:min2;
	}

}

