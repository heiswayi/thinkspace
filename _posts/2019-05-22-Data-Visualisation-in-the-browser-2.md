---
layout: post
title: "Data Visualisation in the browser - 2"
comments: true
description: "Animated Charts Trial 1"
keywords: "dummy content"
---

Let's continue our Visualisation journey! Today, I'll try rendering an **interative bar chart** on the browser, with some basic animation.
Let's create a basic HTML layout for the chart, which we can customise later with CSS and Javascript.
The animation concentration will be on the data percentage, so the length of the bar, and the animation will depend on the data-percentage value.
To make things interesting, we'll allow the user to create random values at the click of a button, and animate the graph according to the new values.

```html
<section class="data">
  <div class="measure" data-percentage="20"></div>

  <div class="bar-wrap">
    <label>Data 1</label>
    <div class="bar blue" data-percentage="94.7"></div>
  </div>
  <div class="bar-wrap">
    <label>Data 2</label>
    <div class="bar green" data-percentage="21"></div>
  </div>
  <div class="bar-wrap">
    <label>Data 3</label>
    <div class="bar red" data-percentage="78.95"></div>
  </div>
  <div class="bar-wrap">
    <label>Data 4</label>
    <div class="bar purple" data-percentage="43"></div>
  </div>
</section>

<a href="#" class="redraw button">Randomise Bars</a>
```

Some Basic CSS :
We'll be using the SCSS(previously SASS), a CSS superset which extends CSS's capabilities and pre-compiles into CSS.

```CSS
*, *:before, *:after{ box-sizing: border-box; }

body{
  font-family: 'Source Sans Pro', sans-serif; font-weight: 300; font-size: 14px; padding: 30px;
  background: #eaeaea;
}

a.button{
  padding: 6px 14px; background-color: #888; color: #FFF;
  border-radius: 4px; text-decoration: none;
  font-size: 1em;
  &:hover{
    background-color: #3a3a3a;
  }
}

h1{
  color: #6a6a6a; line-height: 1.2em; margin: 10px 0;
  font-weight: 300; font-size: 3em;
}
```
Doing some prep for the animation we're going to do further on. We draw a Change measure, that shows us the percentage via a line perpendicular to our graphs. 

```CSS
section.data{
  position: relative; overflow: hidden;
  padding: 0 0 30px 0; margin: 0 0 40px 0;
  
  div.measure{
    position: absolute; height: 100%;
    border-right: 2px dashed #888;
    margin: 0 0 35px 0;
    
    &:after{
      content: "Measure " attr(data-percentage) "%";
      position: absolute; bottom: 0px; right: -3px;
      background-color: #888; color: #FFF;
      padding: 4px 16px 4px 8px;
    }
  }
}
```
Finally defining the design for the bars in the graph. 

```CSS
div.bar-wrap{
  width: 100%;
  display: block; margin: 0 0 20px 0;
  overflow: hidden; 
  
  label{
    font-size: 0.8em; color: #8a8a8a; text-transform: uppercase;
    margin: 0 0 2px 0; display: block;
  }
  
  div.bar{
    height: 40px; width: 0; position: relative;
    
    &:after{
      content: attr(data-percentage) "%";
      display: block; position: absolute; top: 0; right: 0;
      height: 40px; padding: 10px;
    }
    
    &.blue{
      background-color: #61a7c4;
      border-bottom: 3px solid darken(#61a7c4, 10%);
      &:after{ color: #FFF; }
    }
    
    &.green{
      background-color: #61c471;
      border-bottom: 3px solid darken(#61c471, 10%);
      &:after{ color: #FFF; }
    }
    
    &.red{
      background-color: #c46161;
      border-bottom: 3px solid darken(#c46161, 10%);
      &:after{ color: #FFF; }
    }
    
    &.purple{
      background-color: #a461c4;
      border-bottom: 3px solid darken(#a461c4, 10%);
      &:after{ color: #FFF; }
    }
  }
}
```
Now that we're finally done with the styling, let's work out how the animation, as well as the randomise functionality will work.
A function to draw the bars for the very first time:

```javascript
$(document).ready(function(){
  $('.bar').each(function(i, elem){
    drawBar(elem);
  });
  
  $('.measure').each(function(i, elem){
    drawMeasure(elem);
  });
 ``` 
 Once we have the initial graph, we need to redraw the lines every time the randomise button is pressed.
 We've created empty functions uptil now, let's populate the functions with the necessary logic.
 ```javascript
  $('a.redraw').click(function(e){
    e.preventDefault();
    $('.bar').each(function(i, elem){
      randomiseBar(elem);
    });
    $('.measure').each(function(i, elem){
      randomiseMeasure(elem);
    });
  
  });
```
Drawing the bar for the first time. The difference between the first time and the next several states is while we have to draw the line form the start the first time, we only have to make changes to an existing line every time we press randomise. Not start from scratch.

```javascript
  function drawBar(bar) {
    var percentage = $(bar).data('percentage');
    if(percentage > 100){
      percentage = 100;
    }
    $(bar).animate({'width': percentage + '%'}, 'slow');
  }
  
```
Once we have the initial lines, we can populate the `randomisebar` function to re-draw the bar after the initial drawing.

```javascript
  function randomiseBar(bar) {
    var width =  Math.floor(Math.random() * (100 - 20 + 1)) + 20;
    $(bar).animate({'width': width + '%'}, 'slow');
    $(bar).attr('data-percentage', width);
  }
  
```
Now that we have the bars in place, the final step is to render the change measure in our visualisation.

```javascript
   
  function drawMeasure(measure) {
    var percentage = $(measure).data('percentage');
    if(percentage > 100){
      percentage = 100;
    }
    $(measure).animate({'width': percentage + '%'}, 'slow');
  }
  
  function randomiseMeasure(measure) {
    var width =  Math.floor(Math.random() * (100 - 20 + 1)) + 20;
    $(measure).animate({'width': width + '%'}, 'slow');
    $(measure).attr('data-percentage', width);
  }
   
});
```
That's it! Our graph is ready. This code is hosted on codepen, do that you can fork the visualisation, and play around with it.
<div class="video-container">
<iframe height="265" style="width: 100%;" scrolling="no" title="Animated Bar Graph with randomize function" src="//codepen.io/sakshamzs/embed/XwVgjx/?height=265&theme-id=dark&default-tab=css,result" frameborder="no" allowtransparency="true" allowfullscreen="true">
  See the Pen <a href='https://codepen.io/sakshamzs/pen/XwVgjx/'>Animated Bar Graph with randomize function</a> by Saksham Gupta
  (<a href='https://codepen.io/sakshamzs'>@sakshamzs</a>) on <a href='https://codepen.io'>CodePen</a>.
</iframe></div>