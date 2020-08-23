<template>
  <div class="container">
    <Location v-bind="location"/>
    <Temperature v-bind="temperature"/>
  </div>
</template>

<script>
import Location from '~/components/Location.vue'
import Temperature from '~/components/Temperature.vue'

import axios from 'axios'
export default {
  components: {
    Location,
    Temperature
  },
  data () {
    return {
      temperature: {
        tempCentigrade: null, // 摂氏保存用
        tempratureDegree: null, // 天気
        tempratureDescription: null, // 天気詳細
      },
      location: {
        locationTimezone: null, // TimeZone
        wheatherIconSrc: null, // icon格納
      }
    }
  },
  mounted () {
    if (process.browser) {
      if ( navigator.geolocation ) {
        navigator.geolocation.getCurrentPosition(position => {
          let lon = position.coords.longitude;
          let lat = position.coords.latitude;
          const appid = process.env.APP_ID;
          const units = "metric"
          const apiURL = process.env.APP_URL

          // 天気API取得
          axios.get(apiURL, {
            params: {
              lat: lat,
              lon: lon,
              units: units,
              appid: appid,
            }
          }).then(response => {
            console.log(response)
            const resDate = response.data
            
            // 気温取得
            this.temperature.tempCentigrade = resDate.main.temp
            this.temperature.tempratureDegree = this.temperature.tempCentigrade;

            // 天気詳細取得
            const description = resDate.weather[0].description;
            this.temperature.tempratureDescription = description;

            //　国、地域名取得
            const country = resDate.sys.country
            const name = resDate.name
            // 地域ごとの時間および天気
            this.location.locationTimezone = `${country}/${name}`;

            const icon = resDate.weather[0].icon;
            this.location.wheatherIconSrc = `http://openweathermap.org/img/wn/${icon}@2x.png`;
          })
          .catch(response => console.log(response))
        });
      }
    } else {
      this.location.locationTimezone = "hey dis is not working because resons"
    }
  }
}
</script>

<style>
.container {
    height: 100vh;
    display: flex;
    justify-content: center;
    flex-direction: column;
    align-items:center;
    background: linear-gradient(rgb(47,150,163), rgb(48,62,143));
    font-family: sans-serif;
    color: white;
}

</style>
