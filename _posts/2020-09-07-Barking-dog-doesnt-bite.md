---
layout: post
title: "'Barking Dog Doesn't Bite' - why SARS-CoV-2 may be more simple and deadly than we thought"
description: "A recent study published by Garvin MR, Alvarez C, Miller JI, et al. higlights why we were not able to identify COVID-19 main characteristics"
keywords: "covid sars-cov-2 pandemic virus bradykinin"
---

# Reverse-engineering a virus and 'bradykinin storms'

A paper initially published at [July 7th](https://web.archive.org/web/*/https://elifesciences.org/articles/59177) (as of 2020) reads *"A mechanistic model and therapeutic interventions for COVID-19 involving a RAS-mediated bradykinin storm"* with the only relevant content published alongside being a [very short abstract](https://web.archive.org/web/20200709051108/https://elifesciences.org/articles/59177). 

Later on, most of their relevant findings were published on the paper's [official portal](https://elifesciences.org/articles/59177) editing the brief abstract and replacing it with research findings able to explain key characteristics from SARS-CoV-2, keys features which remained attributed to randomness by most scientists due to how they linked by mechanisms that could not be traced back to a single factor.

Using pharmacology and genetics to explain how SARS-CoV-2 works is nothing new, and many respectable papers have tried diverse approaches to this theme, the most notables being:

 - [Network-based drug repurposing for novel coronavirus 2019-nCoV/SARS-CoV-2 (Paper)](https://www.nature.com/articles/s41421-020-0153-3) - [Metrics](https://plu.mx/plum/a/?doi=10.1038/s41421-020-0153-3) <h5>Zhou, Y., Hou, Y., Shen, J. et al. Network-based drug repurposing for novel coronavirus 2019-nCoV/SARS-CoV-2. Cell Discov 6, 14 (2020). https://doi.org/10.1038/s41421-020-0153-3</h5>
 - [Pharmacologic Treatments for Coronavirus Disease 2019 (COVID-19)
(Paper)](https://www.nature.com/articles/s41421-020-0153-3) - [Metrics](https://plu.mx/plum/a/?doi=10.1001/jama.2020.6019)<h5>ZSanders JM, Monogue ML, Jodlowski TZ, Cutrell JB. Pharmacologic Treatments for Coronavirus Disease 2019 (COVID-19): A Review. JAMA. 2020;323(18):1824–1836. doi:10.1001/jama.2020.6019</h5>
 - [Angiotensin-converting enzyme 2 (ACE2) as a SARS-CoV-2 receptor: molecular mechanisms and potential therapeutic target
(Paper)](https://link.springer.com/article/10.1007/s00134-020-05985-9?fbclid=IwAR05sZuejQgHy6X0PCK2bPBMYaTm3jtnMltRNjaGRnwh-FVtz-QLNcQowfk) - [Metrics](https://plu.mx/plum/a/?doi=10.1007/s00134-020-05985-9)<h5>Zhang, H., Penninger, J.M., Li, Y. et al. Angiotensin-converting enzyme 2 (ACE2) as a SARS-CoV-2 receptor: molecular mechanisms and potential therapeutic target. Intensive Care Med 46, 586–590 (2020). https://doi.org/10.1007/s00134-020-05985-9</h5>
 - [Candidate drugs against SARS-CoV-2 and COVID-19
(Paper)](https://www.sciencedirect.com/science/article/pii/S1043661820311671) - [Metrics](https://plu.mx/plum/a/?doi=10.1001/jama.2020.6019)<h5>Dwight L. McKee, Ariane Sternberg, Ulrike Stange, Stefan Laufer, Cord Naujokat, Candidate drugs against SARS-CoV-2 and COVID-19, Pharmacological Research, Volume 157, 2020, 104859, ISSN 1043-6618, https://doi.org/10.1016/j.phrs.2020.104859.
</h5>

Albeit relevant to the matter when discussing pharmacology and SARS-CoV-2 pharmacokinetics properties, they only tend to focus on observable mechanisms and fail to identify underlying conditions that could be attributed to a single common underlying cause, they seem to only be able to explain what has been previously seen or studied, and thus their analysis methodology and provided theories are limited.

Instead of focusing on what they got 'wrong' individually, repeating in an analogous way the bias embedded in their framework, this article will feature the properties that led to a different approach on the theme and why these properties should be relevant to the whole field of bioinformatics when studying novelty pathogenics in future scenarios.


## A brief historical review

Initially understood as a virus weaponized to affect our lungs, authorities quickly noticed something was amiss, shortly afterward a main binding mechanism was identified: angiotensin-2, or ACE-2 receptors, an unusual group with no known mechanism linked to cytokine storms nor repisratory diseases, coupled with these findings came the first wave of hospitalized patients and efforts in identifying the disease characteristics, where doctors noticed this virus
had serious symptoms such as cytokines storms and deadly pneumonia with severe affected lungs as a result, where patients regularly needed artificial breathing (i.e. ventilators) in order to stay alive. 

'Cytokine storm' is a loose term for classifying scenarios where your immunity system cells is unable to properly identify the foreign entity - such as a virus - and as a result it starts attacking its own tissues, 
a behavior that initially classified immune-depressed population and chronic respiratory diseases as higher "deadly risk" for currently infected SARS-CoV-2 patients. 
A conclusion that does not fit meta-analysis from historical data, as smokers were considered to be one of the most at risk groups from initial analysis, instead, [they turned out 
to have a lower hospitalization ratio than your average non-smoker, surprisingly](https://journals.sagepub.com/doi/full/10.1177/2040622320935765), a conclusion supported by data even when considering gender, age distribution, underlying 
 conditions and race.

Instead, scientists started to notice most worrying stealthy characteristics of the virus were actually aimed
at our cardiovascular system, [as the Troponin I biomarker could be used to monitor how severe the infection was on hopistalized
patients](https://www.nature.com/articles/s41569-020-0360-5?fbclid=IwAR3TjvxiEtYQqNkpsPuEuuef94Gp2m4a89YFxubY2pw2FtOxsSpxGZ18TmI), a protein
measured to infer how much damage is being generated to our heart tissues, that's why it is commonly used as a signaler for medics to forecast and alert *heart attacks*.
So anyone with chronic heart diseases was included in the risk group ahead of existing respiratory conditions, as cardiovascular comorbities [started to surge as a comorbity able to predict
a patient outcome in terms of likelihood of survival](https://journals.physiology.org/doi/full/10.1152/ajpheart.00215.2020). 

Another risk factor that increasingly got attention from the medical community were the kidneys, as one of the body's
organ most rich in ACE-2 receptors number counts, it seemed like an intuitive analysis: [kidneys are main targets for the virus](https://www.medrxiv.org/content/medrxiv/early/2020/04/10/2020.03.04.20031120.full.pdf) and a [major risk factor](https://www.nejm.org/doi/full/10.1056/NEJMc2011400).
<h5>This is one of the key characteristics that really surprised me on how backward the initial analysis were if you would consider a 'bradykinin storm' scenario.</h5>