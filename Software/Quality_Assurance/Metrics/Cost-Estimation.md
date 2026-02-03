COCOMO
* Stands for COnstructive COst MOdel.
* A method for modelling software development to yield estimates of effort and cost before undertaking the project.
* Based on a mathematical model of effort, plus empirical constants to parameterize the model.
Simple COCOMO effort prediction
* The simplest COCOMO model uses the estimate: Effort = a (Size) b
    * Where:
        * Effort is measured in person-months.
        * Size is the predicted size of the software in KDSI (“thousands of delivered source instructions”).
Simple COCOMO effort prediction
* The simplest COCOMO model uses the estimate: Effort = a (Size) b
* a and b are empirically derived constants depending on the kind of software:
    * “organic” – stand-alone in-house data processing systems: a = 2.4, b = 1.05
    * “embedded” – real-time or hardware linked systems: a = 3.6, b = 1.2
    * “semi-detached” – in between the two above: a = 3.0, b = 1.12
The downside of COCOMO
* The simple COCOMO model is claimed to give good order of magnitude estimates of required effort.
* But depends on a size estimate – which some say is just as hard to estimate as effort!
* Example:
    * In one experiment managers were asked to estimate software size given the complete specifications.
    * The average deviation from the actual size was 64%.
    * Only 25% of the estimates were within 25% of the actual size.
Simple COCOMO development time prediction
* COCOMO uses a similar model for time given effort: Time = a (Effort) b
    * Where:
        * Time is measured in months.
        * Effort is measured in person-months.
Simple COCOMO development time prediction
* COCOMO uses a similar model for time given effort: Time = a (Effort) b
* Again, a and b are (different) empirically derived constants depending on the kind of software:
    * “organic” – stand-alone in-house data processing systems: a = 2.5, b = 0.38
    * “embedded” – real-time or hardware linked systems: a = 2.5, b = 0.32
    * “semi-detached” – in between the two above: a = 2.5, b = 0.35
Where does the COCOMO model come from?
* COCOMO is based on empirical measurements of the actual effort and cost of past software projects as a function of software size.
* And the derivation of a regression equation to explain them.
* Analysis of the historical data indicates that the logarithm of the effort required to produce a software system has a linear relationship with the logarithm of the size of the software, that is:
    log Effort = log a + b log Size
    * Where log a is the y-intercept of the line and b is the slope of the line.
* Solving for Effort yields the COCOMO effort model: Effort = a (Size) b.
* A similar empirical observation of the historical relationship between Time and Effort yields the COCOMO model for estimating time required.