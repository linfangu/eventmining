# Eventmining
The eventmining project uses calcium imaging data from dyadic animals interacting in the tube test and open arena and aims to identify population activity patterns within and across brains. 

## file description 

### population event analysis 
The basic steps for event mining are: 
* 1 pre-processing (transform data and remove contamination)

signal_transformation.mlx (a Comparison of signal normalization using continuous, continuous at 90% maximum, binary transformations.)
cor_dist_map_all_mice.mlx (Remove duplicated and contaminated cells using correlation-distance map. Cells that have strong correlation with near-by cells are removed.)

* 2 event mining (loop for all popolation synchronized activity/silencing events, test significance with random shuffling data)

For activity events, after 1st round event detection, time with events are removed and the remaining time is used for 2nd round detection, in order to detect more complete event profile. 

“Generate_event_data.m” shows codes for the event mining process, including preprocessing steps

* 3 event processing (remove highly overlapped events, select representative lengths of events, etc.)

Since events are redundant in time and neuronal composition, the following steps are taken:
    - if there are many events with same start (t0) and length (k), only one with highest neuron number (m) is kept.
    - for each event length (k), remove events that are highly overlapped with others in time (>50%).
    - take events at 4 different lengths that span all Ks for analysis. 
Refer to "optimize_event_mining.mlx" and "optimize_event_mining_tube.mlx" for a visualization of the effect of the listed steps. 
In practice, these events processing steps are done separately for each analysis in step 4, and then visualized as lines on the time axis. 

* 4 compare events at different conditions 

A few scientific questions to test are 
_(1) are events of interacting animals more synchronized than non-interacting animals?
To test synchronization of events between animals, we can use distance between events, or the overall overlap in event coverage. 
a comparison of within pair event synchronization and between pair event synchronization is in folder "simplified_event_analysis".
a comparison of same pairs of animals when separated and when interacting is in folder "sep_exp".
_(2) are events correlated with occurance of behaviors?
_(3) the cell composition of events - e.g. what changed in interaction and separation; when cells from two animals jointly form a event 

### basic analysis on the population (dimensionality reduction and stability check)
* clustering 

clustering_method.mlx (Comparison of neuron clustering methods to visualize population structures in the signal)

* pca 

look for the number of stable components in the data.
"multibleReliableDimensionsDemo.mlx"

* ica

Use ica to find components of co-activity patterns in the population
see "ica" folder

* frequency power stability 

At what frequencies are the signals reliable? 
see "stability_analysis.mlx" 
Do different cell types show same patterns of stability at different frequencies? And - across different conditions (separation and interaction)?
See analysis of frequency stability in folders for particular datasets (sep_exp & camkiigaba)
