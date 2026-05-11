---
title: "LM | Fundamentals of Bioacoustics"
header:
  image: '/assets/images/teaserimages/gemini_audio.png'
  caption: 'Generated with Google Gemini'
toc: true
---

Bioacoustics [(Laiolo 2010)](https://doi.org/10.1016/j.biocon.2010.03.025) is an interdisciplinary science dedicated to studying organisms or the environment via sound. It examines both the acoustic signals produced by organisms for communication and navigation, and the ways in which external acoustics, both natural and man-made, impact those same organisms. Studies focus either on the vocalizations of individual species, or the entire environment which is also called the **soundscape** [(Pijanowski. et al. 2011)](https://doi.org/10.1525/bio.2011.61.3.6). 

A soundscape represents the entire acoustic output of an ecosystem, serving as a real-time indicator of biological health and habitat complexity. This holistic approach, often termed "Soundscape Ecology," categorizes sounds into biophony (biological), geophony (geophysical), and anthrophony (human-made) [(Schoeman et al. 2022)](https://doi.org/10.1007/978-3-030-97540-1_7).

This field operates at the intersection of several disciplines. It requires a biological understanding of animal behavior and anatomy, and a robust foundation in data science and informatics to process the vast amounts of audio data generated during field studies. Whether studying the ultrasonic clicks of bats, the complex songs of birds, or the low-frequency pulses of marine mammals, bioacoustics provides a non-invasive window into the natural world.

[![](https://media.springernature.com/full/springer-static/image/chp%3A10.1007%2F978-3-030-97540-1_7/MediaObjects/332811_1_En_7_Fig2_HTML.png?as=webp)](https://doi.org/10.1007/978-3-030-97540-1_7)
*Image source: [Schoeman et al. 2022](https://doi.org/10.1007/978-3-030-97540-1_7). Sketch of the sound sources within soundscapes ranging from wilderness to countryside, to city. Biophony decreases and anthropophony increases while the geophony might vary comparatively little. Example species are sketched along the way with decreasing density and biodiversity. Acoustic habitat generalists occur in multiple, different soundscapes, while acoustic habitat specialists only occur in quite specific soundscapes [(Mullet et al. 2017)](https://doi.org/10.1007/s12304-017-9288-5)*

---

### Measurement of Sound: From PAM to Edge Computing
The methodology for gathering bioacoustic data has undergone a revolution with the introduction of **Passive Acoustic Monitoring (PAM)** [(Ross et al. 2023)](https://doi.org/10.1111/1365-2435.14275). In traditional ecology, researchers often relied on manual observations which were limited by human presence and time constraints. PAM utilizes autonomous recording units (ARUs) that can be deployed in remote or sensitive habitats to record biodiversity without human interference. This approach is particularly effective for monitoring elusive, nocturnal, or rare species that might otherwise go undetected.

Within the current technological landscape, the **AudioMoth** ([Hill et al. 2017](https://doi.org/10.1111/2041-210X.12955)) has emerged as one of the most influential tools for researchers. Its low cost and open-source flexibility allow for large-scale deployments that were previously impossible. You can find technical documentation and deployment guides at the [Open Acoustic Devices website](https://www.openacousticdevices.info/audiomoth). 

Traditional AudioMoths record everything as audio files, which can lead to massive amounts of data piling up. This results in significant costs for data storage, transmission, and computation. Consequently, there is a recent shift towards **[Edge Computing](https://en.wikipedia.org/wiki/Edge_computing)**. Projects such as **Bird@Edge**, developed by [Höchst et al. 2022](https://jonashoechst.de/assets/papers/hoechst2022birdedge.pdf), represent a leap forward where data is no longer just stored for later retrieval. Instead, classification algorithms run directly on the device in the field. This approach allows for real-time biodiversity monitoring and significantly reduces the logistical burden of managing massive amounts of raw audio data. This type of Passive Acoustic Monitoring (PAM) is a core component of larger biodiversity networks, such as the **Natur 4.0** project [(Zeuss et al. 2023)](https://doi.org/10.1111/gcb.17056) conducted here at the **Marburg Open Forest**. By integrating bioacoustics into a broader sensor network, researchers can gain a holistic understanding of ecosystem dynamics in real time: 

<iframe width="560" height="315" src="https://www.youtube.com/embed/u_PPubQTDyY?si=mUTTpDq8W9cBnvyW" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" referrerpolicy="strict-origin-when-cross-origin" allowfullscreen></iframe>

---

### Analysis of Audio Data: From Sound to Information
When an autonomous recorder is retrieved, it typically contains a library of raw **.wav files**. These files capture the pressure fluctuations of the environment, but the true challenge lies in extracting biological meaning from this noise. Modern analysis generally takes two paths: treating the sound as a signal to be measured or as an image (spectrogram) to be classified. 

[![](https://onlinelibrary.wiley.com/cms/asset/fc3cca79-ec99-42c5-9e75-a710accd46c7/gcb17056-fig-0017-m.jpg)](https://doi.org/10.1111/gcb.17056)
*Image source: [Zeuss et al. 2023](https://doi.org/10.1111/gcb.17056). Spectogram of an audio file in the database AudioDB*


#### Soundscape Indices and Machine Learning
**Soundscape Indices** are used when researchers want to analyze the ecosystem as a whole. These mathematical tools measure the complexity of an audio recording without necessarily identifying every individual species. Conversely, when the goal is species-specific, researchers turn to **Machine Learning** and **Deep Learning**. Currently, deep neural networks like **BirdNET** are used to classify specific bird species. By converting sound into a visual spectrogram, these networks detect the acoustic fingerprints of animals with high accuracy. You can experiment with this technology at the [official BirdNET portal](https://birdnet.cornell.edu/).

---

### Regional Case Study: Hessen Bird Monitoring
In Hessen, the [HLNUG](https://www.hlnug.de/) established a network of 65 ARUs covering all of Hessen at the start of this year. This project aims to provide real-time data to help conservationists intervene quickly, such as securing nests for endangered species. They use ARUs with edge computing classification of bird species in the field. This video is in German only:

<div class="video-container">
  <iframe width="560" height="315" src="https://www.youtube.com/embed/2QgWoqpx2VE" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe>
</div>

---
### References

**Hill, A. P., Prince, P., Piña Covarrubias, E., Doncaster, C. P., Snaddon, J. L., & Rogers, A.** (2018). AudioMoth: Evaluation of a smart open‐source acoustic device for monitoring biodiversity. *Methods in Ecology and Evolution*, 9(5), 1199–1211. [https://doi.org/10.1111/2041-210X.12955](https://doi.org/10.1111/2041-210X.12955)

**Höchst, J., Bellafkir, H., Lampe, P., Vogel, K., Mühling, M., Schneider, D., Lindner, K., Rösner, S., Schabo, D. G., Farwig, N., Freisleben, B., & Seeger, B.** (2022). Bird@Edge: Bird Species Recognition at the Edge. In *Proceedings of the 13th International Conference on Computing and Communication (ICC)*. [https://jonashoechst.de/assets/papers/hoechst2022birdedge.pdf](https://jonashoechst.de/assets/papers/hoechst2022birdedge.pdf)

**Laiolo, P.** (2010). The emerging field of bioacoustics in animal conservation. *Biological Conservation*, 143(7), 1635–1645. [https://doi.org/10.1016/j.biocon.2010.03.025](https://doi.org/10.1016/j.biocon.2010.03.025)

**Mullet, T. S., Gagne, S. A., Morton, J. M., & Whitehouse, I.** (2017). The soundscape of an Alaskan wilderness: Thresholds of anthropogenic noise and their effects on biological sound. *Landscape Ecology*, 32, 1467–1490. [https://doi.org/10.1007/s12304-017-9288-5](https://doi.org/10.1007/s12304-017-9288-5)

**Pijanowski, B. C., Farina, A., Gage, S. H., Dumyahn, S. L., & Krause, B. L.** (2011). What is soundscape ecology? *BioScience*, 61(3), 203–216. [https://doi.org/10.1525/bio.2011.61.3.6](https://doi.org/10.1525/bio.2011.61.3.6)

**Ross, S. R. P. J., O'Connell, D. P., Deichmann, J. L., Desjonquères, C., Gasc, A., Phillips, J. N., Sethi, S. S., Wood, C. M., & Burivalova, Z.** (2023). Passive acoustic monitoring as a tool for ecological research and biodiversity monitoring. *Functional Ecology*, 37(2), 325–338. [https://doi.org/10.1111/1365-2435.14275](https://doi.org/10.1111/1365-2435.14275)

**Schoeman, K., et al.** (2022). Soundscapes across environmental gradients. In *Advances in Ecoacoustics*. Springer Nature.

**Zeuss, D., Bald, L., Gottwald, J., Becker, M., Bellafkir, H., Bendix, J., et al.** (2023). Nature 4.0: A networked sensor system for integrated biodiversity monitoring. *Global Change Biology*, 30(1), e17056. [https://doi.org/10.1111/gcb.17056](https://doi.org/10.1111/gcb.17056)