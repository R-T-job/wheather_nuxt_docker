<template>
  <div class="container">
    <div>
      <h1 class="title">
        test-api
      </h1>
      <div>
        <!-- {{ test }} -->
        <div class="links">
          <a
            href="/users"
            class="button--green"
          >
            Users List
          </a>
        </div>
      </div>
    </div>
  </div>
</template>
<script>
import axios from 'axios';
export default {
  data () {
    return {
      lon: null,
      lat: null,
      units: null,
      appid: null,

      temp: null,

      tempratureDescription: null,
      tempratureDegree: null,
      locationTimezone: null,
      wheatherIconSrc: null,
      degreeSection: null,
      degreeSpan: "C",
    }
  },
  mounted () {
    const data = this.asyncData()
    console.log(data)
    if (process.browser) {
      const data = this.asyncData(navigator)
      if ( navigator.geolocation ) {
        navigator.geolocation.getCurrentPosition(position => {
          console.log(position)
          this.lon = position.coords.longitude;
          this.lat = position.coords.latitude;
          this.appid = "9aa48215a10b18b7de567a747bb16e39";
          this.units = "metric"
          const api = `https://api.openweathermap.org/data/2.5/weather?lat=${this.lat}&lon=${this.lon}&units=${this.units}&appid=${this.appid}`
          fetch(api)
            .then(response => {
              return response.json();
            })
            .then(data => {
              console.log(data)
              this.temp = data.main.temp;
              const description = data.weather[0].description;

              this.tempratureDegree = this.temp;
              this.tempratureDescription = description;

              const country = data.sys.country
              const name = data.name
            
              this.locationTimezone = `${country}/${name}`;
              const icon = data.weather[0].icon;

              this.wheatherIconSrc = `http://openweathermap.org/img/wn/${icon}@2x.png`;
            })
        });
      }
    } else {
      locationTimezone = "hey dis is not working because resons"
    }
  },
  methods: {
    async asyncData (navigator) {
      console.log(navigator)
      let a = axios.get('/user/test', {
              params: {
                // ここにクエリパラメータを指定する
                navigator: navigator
              }
            });
    },
    changeDegree(){
      console.log(this.degreeSpan)
      if(this.degreeSpan === "C"){
        this.degreeSpan = "F";
        let farenheit = (this.temp) * (9 / 5) + 32
        this.tempratureDegree = Math.floor(farenheit);
      } else {
        this.degreeSpan = "C";
        this.tempratureDegree = this.temp;
      }
    }
  }
}
// export default {
//   async asyncData ({ $http }) {
//     const test = await $http.$get('/api/test')
//     return {
//       test
//     }
//   },
//   mounted: function(){
//     console.log('mounted')
//   }
// }
</script>

<style scoped>
.container {
  margin: 0 auto;
  min-height: 100vh;
  display: flex;
  justify-content: center;
  align-items: center;
  text-align: center;
}

.title {
  font-family:
    'Quicksand',
    'Source Sans Pro',
    -apple-system,
    BlinkMacSystemFont,
    'Segoe UI',
    Roboto,
    'Helvetica Neue',
    Arial,
    sans-serif;
  display: block;
  font-weight: 300;
  font-size: 100px;
  color: #35495e;
  letter-spacing: 1px;
}

.subtitle {
  font-weight: 300;
  font-size: 42px;
  color: #526488;
  word-spacing: 5px;
  padding-bottom: 15px;
}

.links {
  padding-top: 15px;
}
</style>
