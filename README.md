# MATLAB-General-Utilities
A collection of generalized primitive MATLAB utilities. As a general warning its worth noting I frequently overload built-in functions; that said, when I do I aim to leave the previous contract completely intact and unmodified, only acting to extend functionality... Most of the time at least; that said I do not plan on introducing overloads that are imcompatible with MATLAB and would produce errors in this repository; any likely will avoid them all together unless I find them being used frequently enough to be practical musts. Additionally it is worth noting: that I often performance test many different ways of performing operations, or processing data; and refactor my code somewhat frequently. Generally I've noticed its wise to assume the best road is using generalized primitive working patterns in non-nested for-loops, with column aligned data. I discuss very robust and simplistic patterns for most operations I find myself doing in my broadcasting repository if interested; but in the event you do notice something you think may suffer from iteration I would encourage you to poke around a bit; even when iteration loses, its often neglibile, I focus quite a bit on keeping things lean but I prefer taking losing out on the flashy-ier performance metrics if it results in consistent timing. Despite that if you do notice anything you think could use a look over please point it out. Lastly this repository will likely grow as time progresses I have a continental sized codebase of utilities which I've only recently started polishing up. 

# Array Creation Functions
These are small utilities to allow index focused utility arrays, random data class test arrays to be generated without the verbosity required from the default built-in functions. Typically I only use these in scripts when testing, outside of `matrix()` which is universally useful.

# Math Utilities
The definition of math here being rather loose. Thes functions are numerical or boolean operations. I frequently will create variants of functions that behave slightly differnetly or would like to extend a mathematical concept into more generalized behavior. At their core these are computational utilities.

# Misc Utilities
I use MATLAB as a calculator that stays open when my computer is on, as a result certain common tasks are nice to have, if less commonly using in one's codebase; as of now you'll see AWG to mm converters and an equivalent impedence function, as I find doing either off the dome rather difficult. 

# Random Data Generation
These functions are designed to allow quick mock data to be generated when testing processing algorithms that would benefit from data that more closely resembles something realistic. 

# ND Size Utilities
These are small wrapper functions for commonly used operations. More specifically, these functions concern themselves with manipulating data, or generating vectors that act as tools to manipulate data.

# Text Utilities
These functions provide text processing capabilities. Pattern matching utilities, and overloads extending the built-in string methods.
