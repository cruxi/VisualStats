
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
  return Math.max.apply(null, this)
}


/**
 * extend Array to determine minimum value
 */
Array.prototype.min = function() {
  return Math.min.apply(null, this)
}