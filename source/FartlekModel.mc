using Toybox.Attention as Attention;

class FartlekModel {

    public var mode;

    hidden var mWorkoutType;
    hidden var mWorkouts;
    hidden var mWkNumber;
    hidden var mWKRound;
    hidden var mCounter;
    hidden var mPauseTime;
 
    function initialize(){
        mWorkouts = [];
        mWkNumber = 0; 
        mWKRound = 0;
        mode = "Warm Up";

        var app = Application.getApp();
        var workoutNumber = app.getProperty("workoutNumber") == null? 0 : app.getProperty("workoutNumber");
        mWorkoutType = app.getProperty("workoutType") == null? 0 : app.getProperty("workoutType");
        mCounter = app.getProperty("warmUpTimeSeconds") == null? 300 : app.getProperty("warmUpTimeSeconds");
        mPauseTime = app.getProperty("pauseTimeSeconds") == null? 300 : app.getProperty("pauseTimeSeconds");

        var array = Application.loadResource(Rez.JsonData.workouts);

        for (var i = 0; i < array[workoutNumber]["data"].size(); i++){
            mWorkouts.add(array[workoutNumber]["data"][i]);
        }
    }

    function tick() {
        switch(mWorkoutType){
            case 0:
                definedWorkout();
            break;
        }

    }

    function definedWorkout() {
        if(mCounter == 3){
            vibrate();
        }

        if(mode.equals("Warm Up") && mCounter <= 0){
            mCounter = mWorkouts[mWkNumber]["fast"];
            mode = "Fast";
            mWKRound = mWorkouts[mWkNumber]["repeat"] * 2 - 1;
        } else if(mWKRound == 0 && !mode.equals("Pause") && mCounter <= 0) {
            mCounter = mPauseTime;
            mode = "Pause";
        } else if(mWKRound == 0 && mCounter <= 0) {
            mWkNumber++;
            if(mWkNumber == mWorkouts.size()){
                mode = "Finished";
                mCounter = 10000;
            } else {
                mCounter = mWorkouts[mWkNumber]["fast"];
                mode = "Fast";
                mWKRound = mWorkouts[mWkNumber]["repeat"] * 2 - 1;
            }
        } else if(mode.equals("Fast") && mCounter <= 0) {
            mWKRound--;
            mode = "Slow";
            mCounter = mWorkouts[mWkNumber]["slow"];
        } else if(mode.equals("Slow") && mCounter <= 0) {
            mWKRound--;
            mode = "Fast";
            mCounter = mWorkouts[mWkNumber]["fast"];
        }
        mCounter--;
    }
    
    function randomWorkout() {
    
    }

    function distanceWorkout() {

    }

    function vibrate(){
        if (Attention has :vibrate) {
            var vibrateData = [ 
                new Attention.VibeProfile(50, 500 ),
                new Attention.VibeProfile(0, 500),
                new Attention.VibeProfile(50, 500 ),
                new Attention.VibeProfile(0, 500),
                new Attention.VibeProfile(100, 1000 )
            ];
            Attention.vibrate( vibrateData );
        }
	}
}