var ctx = document.getElementById('market-share').getContext('2d');
var chart = new Chart(ctx, {
// The type of chart we want to create
type: 'pie',


// The data for our dataset
data: {
labels: ["Flower", "Dry Concentrates", "Oil Concentrates","Topicals","Edibles","Supplies"],
datasets: [{
  backgroundColor: ['rgb(70, 137, 102)','rgb(255, 240, 165)','rgb(255, 176, 59)','rgb(182, 73, 38)','rgb(142, 40, 0)','rgb(44, 62, 80)'],
  data: [100, 25, 47, 52, 12,77],
}]
},

// Configuration options go here
options: {}
});


var ctx = document.getElementById('store-product').getContext('2d');
var chart = new Chart(ctx, {
// The type of chart we want to create
type: 'pie',


// The data for our dataset
data: {
labels: ["Flower", "Dry Concentrates", "Oil Concentrates","Topicals","Edibles","Supplies"],
datasets: [{
  backgroundColor: ['rgb(70, 137, 102)','rgb(255, 240, 165)','rgb(255, 176, 59)','rgb(182, 73, 38)','rgb(142, 40, 0)','rgb(44, 62, 80)'],
  data: [100, 25, 47, 52, 12,77],
}]
},

// Configuration options go here
options: {}
});

var ctx = document.getElementById('average-price').getContext('2d');
var chart = new Chart(ctx, {
// The type of chart we want to create
type: 'line',
// The data for our dataset
data: {
    labels:
      ["Sativa ", "Indica ", "Hybrid "],
    datasets:
      [{
        label:'last 30 days by day',
        fill: false,
        backgroundColor: ['rgb(70, 137, 102)'],
        borderColor: ['rgb(70, 137, 102)'],
        data: [1, 2, 3, 4, 5],
      },
      {
        label:'3-months by day',
        fill: false,
        backgroundColor: ['rgb(255, 176, 59)'],
        borderColor: ['rgb(255, 176, 59)'],
        data: [5, 4, 2, 1, 3],
      },
      {
        label:'1 year by week',
        fill: false,
        backgroundColor: ['rgb(142, 40, 0)'],
        borderColor: ['rgb(142, 40, 0)'],
        data: [2.5, 3.3, 4, 5, 1],
      },{
        label:'last 5 years by month',
        fill: false,
        backgroundColor: ['rgb(44, 62, 80)'],
        borderColor: ['rgb(44, 62, 80)'],
        data: [1.5, 4.3, 2, 3, 5],
      }
    ],
},


// Configuration options go here
options: {}
});




// BASIC RESEARCH

var ctx = document.getElementById('depth-market-share').getContext('2d');
var chart = new Chart(ctx, {
// The type of chart we want to create
type: 'pie',


// The data for our dataset
data: {
labels: ["Flower", "Dry Concentrates", "Oil Concentrates","Topicals","Edibles","Supplies"],
datasets: [{
  backgroundColor: ['rgb(70, 137, 102)','rgb(255, 240, 165)','rgb(255, 176, 59)','rgb(182, 73, 38)','rgb(142, 40, 0)','rgb(44, 62, 80)'],
  data: [100, 25, 47, 52, 12,77],
}]
},

// Configuration options go here
options: {}
});


var ctx = document.getElementById('depth-store-product').getContext('2d');
var chart = new Chart(ctx, {
// The type of chart we want to create
type: 'pie',


// The data for our dataset
data: {
labels: ["Flower", "Dry Concentrates", "Oil Concentrates","Topicals","Edibles","Supplies"],
datasets: [{
  backgroundColor: ['rgb(70, 137, 102)','rgb(255, 240, 165)','rgb(255, 176, 59)','rgb(182, 73, 38)','rgb(142, 40, 0)','rgb(44, 62, 80)'],
  data: [100, 25, 47, 52, 12,77],
}]
},

// Configuration options go here
options: {}
});

var ctx = document.getElementById('depth-average-price').getContext('2d');
var chart = new Chart(ctx, {
// The type of chart we want to create
type: 'line',
// The data for our dataset
data: {
    labels:
      ["Sativa ", "Indica ", "Hybrid "],
    datasets:
      [{
        label:'last 30 days by day',
        fill: false,
        backgroundColor: ['rgb(70, 137, 102)'],
        borderColor: ['rgb(70, 137, 102)'],
        data: [1, 2, 3, 4, 5],
      },
      {
        label:'3-months by day',
        fill: false,
        backgroundColor: ['rgb(255, 176, 59)'],
        borderColor: ['rgb(255, 176, 59)'],
        data: [5, 4, 2, 1, 3],
      },
      {
        label:'1 year by week',
        fill: false,
        backgroundColor: ['rgb(142, 40, 0)'],
        borderColor: ['rgb(142, 40, 0)'],
        data: [2.5, 3.3, 4, 5, 1],
      },{
        label:'last 5 years by month',
        fill: false,
        backgroundColor: ['rgb(44, 62, 80)'],
        borderColor: ['rgb(44, 62, 80)'],
        data: [1.5, 4.3, 2, 3, 5],
      }
    ],
},


// Configuration options go here
options: {}
});
