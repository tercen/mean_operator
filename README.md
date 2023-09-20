# mean operator

##### Description

`mean` operator computes the mean of a set of data points.

##### Usage

Data Input|.
---|---
`y-axis`            | Measurement value, per cell 
`x-axis` (optional) | Second measurement value, per cell 

Data Output|.
---|---
`value`          | Mean of y values if no x axis is present in the input.
`mean_y`          | Mean of y values if x axis is present in the input.
`mean_x`          | Mean of x values if x axis is present in the input.

##### Details

The operator takes all the values of a cell and calculates their mean. The computation is done per cell. There is one value calculated and returned for each of the input cell.

##### See Also

[product_operator](https://github.com/tercen/product_operator), [sum_operator](https://github.com/tercen/sum_operator)

