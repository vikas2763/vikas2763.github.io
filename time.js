

1 ) get time

var now = new Date(Date.now());
var formatted = now.getHours() + ":" + now.getMinutes() + ":" + now.getSeconds();

https://stackoverflow.com/questions/4517672/how-to-add-20-minutes-to-a-current-date



2 )get current time 
var time = new Date();
time = time.toLocaleString('en-US', { hour: 'numeric',minute:'numeric', hour12: true });



3 )get 20 min later time 
var currentDate = new Date();
var twentyMinutesLater = new Date(currentDate.getTime() + (20 * 60 * 1000));
time = twentyMinutesLater.toLocaleString('en-US', { hour: 'numeric',minute:'numeric', hour12: true });


4 ) get 20 min past time

var currentDate = new Date();
var twentyMinutesLater = new Date(currentDate.getTime() - (20 * 60 * 1000));
time = twentyMinutesLater.toLocaleString('en-US', { hour: 'numeric',minute:'numeric', hour12: true });


5 )Program


        <script type="text/javascript">
            var nIntervId;

            function updateTime() {
                nIntervId = setInterval(flashTime, 1000*1);
            }

            function flashTime() {
         var d1 = new Date (),
							d2 = new Date ( d1 );
							d2.setMinutes ( d1.getMinutes() - 20 );
		d2 = d2.toLocaleString('en-US', { hour: 'numeric',minute:'numeric', hour12: true });
              $('#my_box1').html(d2);   
            }


            $(function() {
                updateTime();
            });
        </script>

        <div id="my_box1">
            <p>Hello World</p>
        </div>






 


