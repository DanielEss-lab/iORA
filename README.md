# iORA

For many students, the cost and process of obtaining a physical model kit set causes delays in student use or completely impedes its use. Therefore, a free, instant access, easy to use and highly interactive qualitative/quantitative virtual model to visualize static structures, transition states, reactive intermediates, and entire reaction pathways is highly desirable. While there are websites and older programs that offer animations of organic reactions, they are generally hard to find, and are either significantly outdated, have compatibility issues with browsers and platforms, or do not have both qualitative and quantitative information. Also, most animations found on the web or in older programs are typically not generated from quantum-mechanical calculations or simulations. 

Our goal is to develop a free, easily downloadable, easy to use, high image quality, highly interactive smartphone application that provides 3D visualization of chemical reactions based on quantum- mechanical simulations (see Fig. I). While there are a few chemistry smartphone applications that can be used to visualize organic compounds, such as WebMO, AR VR Molecules, or iSpartan, they are generally cost prohibitive (often because of in-app purchases) and do not provide chemical reaction information.

### Progress

iORA has officially been released to the App Store and is fully functional! We now hope to add features/QOL improvements to the app as we continue user testing. 

Features to be added: 
  - The ability to view solvent
  - Better lighting and customization
  
Features that have been finished: 
  - Transition States
  - The ability to select/highlight atoms and view distances
  - Dihedral angles
  - Supplemental reading on select reactions
  - Options menu
  - Tutorial page
  
### BONDING ALGORITHM

In order to prepare reaction files for iORA, they are first ran through our [custom processor](https://github.com/jaredrossberg/byu-babel) which calculates bond information. This processor supports partial bonds, unlike OpenBabel which we had previously considered using. This results in much more accurate bondings and removes the need to calculate bonds on the fly when loading the reaction.
