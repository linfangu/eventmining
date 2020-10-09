# Eventmining
The eventmining project using data from dyadic animals interacting in the tube test and open arena. 
## file description 
### Pre-processing 
* Signal Transformation 

Comparison of signal normalization using continuous, continuous at 90% maximum, binary transformations.

signal_transformation.mlx 
* remove contamination

Remove duplicated and contaminated cells using correlation-distance map. Cells that have strong correlation with near-by cells are removed.

cor_dist_map_all_mice.mlx -> Correlation-distance map that is used to determine cell contamination to be removed 
### Eventmining
* Eventmining 

Find events where cells are significantly activated together for certain time. 

After 1st round event detection, time with events are removed and the remaining time is used for 2nd round detection, in order to detect more complete event profile.
* Anti-event mining

Find events where cells are significantly inactivated together for certain time. 
* All_events

Alignment of 1st and 2nd round events and anti-events to behaviours and trial onsets.

4 mlx files of tube test and open arena with continuous/binary data. 
### Cell sorting 
* clustering method

3 clustering methods can be used: mapTmap, UMAP, event cells. 

clustering_method.mlx -> Comparison of neuron clustering methods to visualize population structures in the signal 
* Apply cell sorting to cells from multiple mice

sort_2_mouse.mlx -> Concatenate cells from a pair of mice together and perform cell clustering to visualize inter-brain population structures. 

