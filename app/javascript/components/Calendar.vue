<template>
  <div>
      <FullCalendar
        :options='calendarOptions'
        ref="fullCalendar"
       >
        <template
        v-slot:eventContent='arg'
        >
          <b>{{ arg.timeText }}</b>
          <i>{{ arg.event.title }}</i>
        </template>
      </FullCalendar>
  </div>
</template>
<script>
import FullCalendar from '@fullcalendar/vue';
import dayGridPlugin from '@fullcalendar/daygrid';
import interactionPlugin from '@fullcalendar/interaction';
import timeGridPlugin from "@fullcalendar/timegrid";
import ListPlugin from '@fullcalendar/list';
import jaLocale from "@fullcalendar/core/locales/ja";


export default {
  components: {
    FullCalendar
  },
  props: {
    events: {
      type: Array,
    }
  },
   data() {
    return {
      calendarOptions: {
        plugins: [dayGridPlugin, timeGridPlugin, interactionPlugin, ListPlugin],
        headerToolbar: {
          left: 'prev,next today',
          center: 'title',
          right: 'dayGridMonth,timeGridWeek,timeGridDay,listWeek'
        },
        selectable: true,
        initialEvents: this.events,
        locale:jaLocale,
        editable: true,
        eventClick: this.handleEventClick,
        eventChange: this.handleEventChange,
      },
      calendarApi: null,
    }
  },
  watch: {
    events:  function(newEvents) {
      const oldEvents = this.calendarApi.getEvents()

      this.AddNewEvents(newEvents, oldEvents)

      this.removeEvents(newEvents, oldEvents)
    }
  },
  mounted() {
    this.calendarApi = this.$refs.fullCalendar.getApi()
  },
  methods: {
    AddNewEvents: function(newEvents, oldEvents) {
      const oldEventIds =  oldEvents.map(oldEvent => { return oldEvent.id})
      newEvents.forEach((newEvent) => {
        if(!oldEventIds.includes(newEvent.id)) this.calendarApi.addEvent(newEvent)
      })
    },
    removeEvents: function(newEvents, oldEvents) {
      const newEventIds = newEvents.map(newEvent => { return newEvent.id })
      oldEvents.forEach((oldEvent) => {
        if(!newEventIds.includes(oldEvent.id)) oldEvent.remove()
        }
      )
    },
    handleEventClick: function(eventInfo) {
      this.$emit("eventClick", eventInfo)
    },
    handleEventChange: function(eventInfo) {
      this.$emit("eventChange", eventInfo)
    }
  }
}
</script>