// Chart for research page

// Flowers-bar-chart

var ctx = document.getElementById('average-bar-chart').getContext('2d');
var chart = new Chart(ctx, {
    // The type of chart we want to create
    type: 'bar',

    // The data for our dataset
    data: {
        labels: ["Sativa", "Indicas", "Hybrids"],
        datasets: [{
            label: 'My Transactions',
            backgroundColor: 'rgb(52, 152, 219)',
            data: [100,1000,2000,3000,4000]
        },
        {
            label: 'Market Transactions',
            backgroundColor: 'rgb(231, 76, 60)',
            data: [100,1000,2000,3000,4000]
        }
      ]
    },

    // Configuration options go here
    options: {
      responsive: true,
          legend: {
              position: 'bottom',
          }
    }

});

// Flowers-pie-chart

var ctx = document.getElementById('sativa-pie-chart').getContext('2d');
var chart = new Chart(ctx, {
// The type of chart we want to create
type: 'pie',


// The data for our dataset
data: {
  labels: ["My Volume","Market Volume"],
  datasets: [{
    backgroundColor: ['rgb(52, 152, 219)','rgb(231, 76, 60)'],
    data: [100, 25],
}]
},

// Configuration options go here

    options: {
      responsive: true,
          legend: {
              position: 'bottom',
          }
    }

});

var ctx = document.getElementById('indica-pie-chart').getContext('2d');
var chart = new Chart(ctx, {
// The type of chart we want to create
type: 'pie',


// The data for our dataset
data: {
  labels: ["My Volume","Market Volume"],
  datasets: [{
    backgroundColor: ['rgb(52, 152, 219)','rgb(231, 76, 60)'],
    data: [50,50],
}]
},

// Configuration options go here

    options: {
      responsive: true,
          legend: {
              position: 'bottom',
          }
    }

});

var ctx = document.getElementById('hybrid-pie-chart').getContext('2d');
var chart = new Chart(ctx, {
// The type of chart we want to create
type: 'pie',


// The data for our dataset
data: {
  labels: ["My Volume","Market Volume"],
  datasets: [{
    backgroundColor: ['rgb(52, 152, 219)','rgb(231, 76, 60)'],
    data: [10, 90],
}]
},

// Configuration options go here

    options: {
      responsive: true,
          legend: {
              position: 'bottom',
          }
    }

});


// Concentrates-bar-chart

var ctx = document.getElementById('concentrates-bar-chart').getContext('2d');
var chart = new Chart(ctx, {
    // The type of chart we want to create
    type: 'bar',

    // The data for our dataset
    data: {
        labels: ["Dry Concentrates", "Dry Concentrates"],
        datasets: [{
            label: 'My Transactions',
            backgroundColor: 'rgb(52, 152, 219)',
            data: [2000,3000,1500,2050,4000]
        },
        {
            label: 'Market Transactions',
            backgroundColor: 'rgb(231, 76, 60)',
            data: [2000,3500,1500,2050,4000]
        }
      ]
    },

    // Configuration options go here
    options: {
      responsive: true,
          legend: {
              position: 'bottom',
          }
    }

});



//  Concentrates-pie-chart

var ctx = document.getElementById('dry-concentrates-pie-chart').getContext('2d');
var chart = new Chart(ctx, {
// The type of chart we want to create
type: 'pie',


// The data for our dataset
data: {
  labels: ["My Volume","Market Volume"],
  datasets: [{
    backgroundColor: ['rgb(52, 152, 219)','rgb(231, 76, 60)'],
    data: [50,50],
}]
},

// Configuration options go here

    options: {
      responsive: true,
          legend: {
              position: 'bottom',
          }
    }

});

var ctx = document.getElementById('oil-concentrates-pie-chart').getContext('2d');
var chart = new Chart(ctx, {
// The type of chart we want to create
type: 'pie',


// The data for our dataset
data: {
  labels: ["My Volume","Market Volume"],
  datasets: [{
    backgroundColor: ['rgb(52, 152, 219)','rgb(231, 76, 60)'],
    data: [10, 90],
}]
},

// Configuration options go here

    options: {
      responsive: true,
          legend: {
              position: 'bottom',
          }
    }

});

// Edibles-bar-chart

var ctx = document.getElementById('edibles-bar-chart').getContext('2d');
var chart = new Chart(ctx, {
    // The type of chart we want to create
    type: 'bar',

    // The data for our dataset
    data: {
        labels: ["Dry Concentrates", "Dry Concentrates"],
        datasets: [{
            label: 'My Transactions',
            backgroundColor: 'rgb(52, 152, 219)',
            data: [2000,3000,1500,2050,4000]
        },
        {
            label: 'Market Transactions',
            backgroundColor: 'rgb(231, 76, 60)',
            data: [2000,3500,1500,2050,4000]
        }
      ]
    },

    // Configuration options go here
    options: {
      responsive: true,
          legend: {
              position: 'bottom',
          }
    }

});



//  Edibles-pie-chart

var ctx = document.getElementById('edibles-pie-chart').getContext('2d');
var chart = new Chart(ctx, {
// The type of chart we want to create
type: 'pie',


// The data for our dataset
data: {
  labels: ["My Volume","Market Volume"],
  datasets: [{
    backgroundColor: ['rgb(52, 152, 219)','rgb(231, 76, 60)'],
    data: [50,50],
}]
},

// Configuration options go here

    options: {
      responsive: true,
          legend: {
              position: 'bottom',
          }
    }

});

var ctx = document.getElementById('edibles-pie-chart').getContext('2d');
var chart = new Chart(ctx, {
// The type of chart we want to create
type: 'pie',


// The data for our dataset
data: {
  labels: ["My Volume","Market Volume"],
  datasets: [{
    backgroundColor: ['rgb(52, 152, 219)','rgb(231, 76, 60)'],
    data: [10, 90],
}]
},

// Configuration options go here

    options: {
      responsive: true,
          legend: {
              position: 'bottom',
          }
    }

});

// Overall market activity
var ctx = document.getElementById('overall-market-activity').getContext('2d');
var chart = new Chart(ctx, {
// The type of chart we want to create
type: 'line',
// The data for our dataset
data: {
    labels:
      ["Day 1", "Day 2", "Day 3","Day 4","Day 5","Day 6","Day 7"],
    datasets:
      [{
        label:'Average Market Price',
        fill: false,
        backgroundColor: ['rgb(52, 152, 219)'],
        borderColor: ['rgb(52, 152, 219'],
        data: [0,500,1000,1500,2000,2500,3000],
      },
      {
        label:'Average Market Volume',
        fill: false,
        backgroundColor: ['rgb(231, 76, 60)'],
        borderColor: ['rgb(231, 76, 60)'],
        data: [1000,800,250,2570,1580,3000,200],
      }
    ],
},


// Configuration options go here
  options: {
    responsive: true,
        legend: {
            position: 'bottom',
        }
  }
});
