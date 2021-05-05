# COVID-19 Vaccination Slot Booking Script

This very basic CLI based script can be used to automate covid vaccination slot booking on Co-WIN Platform. 

### Important: 
- POC project. **Use at your own risk**.
- Do NOT use unless all beneficiaries selected are supposed to get the same vaccine and dose. 
- No option to register new user or add beneficiaries. This can be used only after beneficiary has been added through the official app/site
- If you accidentally book a slot, don't worry. You can always login to the official portal and cancel that.
- API Details: https://apisetu.gov.in/public/marketplace/api/cowin/cowinapi-v2
- And finally, I know code quality probably isn't great. Suggestions are welcome.


### Usage:

Run the script file as show below:

```
python slot_booking.py
```
If you're on Linux, install the beep package before running the Python script. To install beep, run:
```
sudo apt-get install beep
```
If you already have a bearer token, you can also use:
```
python slot_booking.py --token=YOUR-TOKEN-HERE
```
### Use as Docker

- Build the docker image using `docker build -t vaccine-slot . `
- Run the code `docker run -it vaccine-slot`

### Third-Party Package Dependency:
- ```tabulate``` : For displaying data in tabular format.
- ```requests``` : For making GET and POST requests to the API.
- ```inputimeout``` : For creating an input with timeout.

Install all dependencies by running:
```
pip install -r requirements.txt
```

### Steps:
1. Run script:
	```python slot_booking.py```
2. Select Beneficiaries. Read the important notes. You can select multiple beneficiaries by providing comma-separated index values such as ```1,2```:
	```
	/Users/vikpandey/env/bin/python /Users/vikpandey/PycharmProjects/covid-vaccine-booking/covid-vaccine-slot-booking.py
	Enter the registered mobile number: ██████████
	Requesting OTP with mobile number ██████████..
	Enter OTP: 605030
	Validating OTP..
	Token Generated: █████████████████████████████████████████████████████████████
	Fetching registered beneficiaries.. 
	+-------+----------------------------+--------------------+-----------+-------+
	|   idx |   beneficiary_reference_id | name               | vaccine   |   age |
	+=======+============================+====================+===========+=======+
	|     1 |             ██████████████ | ██████████████████ |           |    ██ |
	+-------+----------------------------+--------------------+-----------+-------+
	|     2 |             ██████████████ | ████████████       |           |    ██ |
	+-------+----------------------------+--------------------+-----------+-------+

		################# IMPORTANT NOTES #################
		# 1. While selecting beneficiaries, make sure that selected beneficiaries are all taking the same dose: either first OR second.
		#    Please do no try to club together booking for first dose for one beneficiary and second dose for another beneficiary.
		#
		# 2. While selecting beneficiaries, also make sure that beneficiaries selected for second dose are all taking the same vaccine: COVISHIELD OR 			     COVAXIN.
		#    Please do no try to club together booking for beneficiary taking COVISHIELD with beneficiary taking COVAXIN.
		#
		# 3. If you're selecting multiple beneficiaries, make sure all are of the same age group (45+ or 18+) as defined by the govt.
		#    Please do not try to club together booking for younger and older beneficiaries.
		###################################################

	Enter comma separated index numbers of beneficiaries to book for : 1,2
	
	```


3. Ensure correct beneficiaries are getting selected:
	```
	Selected beneficiaries: 
	+-------+----------------------------+-----------+-------+
	|   idx |   beneficiary_reference_id | vaccine   |   age |
	+=======+============================+===========+=======+
	|     1 |             ██████████████ |           |    ██ |
	+-------+----------------------------+-----------+-------+
	|     2 |             ██████████████ |           |    ██ |
	+-------+----------------------------+-----------+-------+
	```

4. Select a state
	```
	+-------+-----------------------------+  
	| idx   | state                       |  
	+=======+=============================+  
	| 1     | Andaman and Nicobar Islands |  
	+-------+-----------------------------+  
	| 2     | Andhra Pradesh              |  
	+-------+-----------------------------+
	+-------+-----------------------------+
	+-------+-----------------------------+  
	| 35    | Uttar Pradesh               |  
	+-------+-----------------------------+  
	| 36    | Uttarakhand                 |  
	+-------+-----------------------------+  
	| 37    | West Bengal                 |  
	+-------+-----------------------------+
	```
	```
	Enter State index: 17
	```
5. Select districts you are interested in. Multiple districts can be selected by providing comma-separated index values
	```
	+-------+--------------------+  
	| idx   | district           |  
	+=======+====================+  
	| 1     | Alappuzha          |  
	+-------+--------------------+  
	| 2     | Ernakulam          |  
	+-------+--------------------+  
	| 3     | Idukki             |  
	+-------+--------------------+
	+-------+--------------------+
	+-------+--------------------+  
	| 13    | Thrissur           |  
	+-------+--------------------+  
	| 14    | Wayanad            |  
	+-------+--------------------+
	```
	```
	Enter comma separated index numbers of districts to monitor : 3,4
	```
6. Ensure correct districts are getting selected.
	```
	Selected districts: 
	+-------+---------------+-----------------+-----------------------+
	|   idx |   district_id | district_name   |   district_alert_freq |
	+=======+===============+=================+=======================+
	|     1 |           265 | Bangalore Urban |                   880 |
	+-------+---------------+-----------------+-----------------------+
	|     2 |           294 | BBMP            |                  1100 |
	+-------+---------------+-----------------+-----------------------+
	```
7. Enter the minimum number of slots to be available at the center:
	```
	================================= Additional Info =================================
	Filter out centers with availability less than ? Minimum 2 : 2
	How often do you want to refresh the calendar (in seconds)? Default 15. Minimum 5. : 15
	```
8. Script will now start to monitor slots in these districts every 15 seconds.
	```
	===================================================================================
	Centers available in Bangalore Urban from 06-05-2021 as of 2021-05-05 09:49:46: 52
	Centers available in BBMP from 06-05-2021 as of 2021-05-05 09:49:46: 99
	===================================================================================
	Centers available in Bangalore Urban from 06-05-2021 as of 2021-05-05 09:50:01: 52
	Centers available in BBMP from 06-05-2021 as of 2021-05-05 09:50:01: 99
	===================================================================================
	Centers available in Bangalore Urban from 06-05-2021 as of 2021-05-05 09:50:18: 52
	Centers available in BBMP from 06-05-2021 as of 2021-05-05 09:50:18: 99
	```
9. If at any stage your token becomes invalid, the script will make a beep and prompt for ```y``` or ```n```. If you'd like to continue, provide ```y``` and proceed to allow using same mobile number
	```
	Token is INVALID.  
	Try for a new Token? (y/n): y
	Try for OTP with mobile number ███████████? (y/n) : y
	Enter OTP: 888888
	```  
11. When a center with more than minimum number of slots is available, the script will make a beep sound - different frequency for different district. It will then display the available options as table:
	```
	===================================================================================  
	Centers available in █████████████ from 06-05-2021 as of 2021-05-05 09:51:46: 1  
	Centers available in █████████ from 06-05-2021 as of 2021-05-05 09:52:46: 0  
	+-------+----------------+------------+-------------+------------+------------------------------------------------------------------------------+  
	| idx   | name           | district   | available   | date       | slots                                                                        |  
	+=======+================+============+=============+============+==============================================================================+  
	| 1     | █████████████  | █████████  | 30          | 06-05-2021 | ['09:00AM-10:00AM', '10:00AM-11:00AM', '11:00AM-12:00PM', '12:00PM-02:00PM'] |  
	+-------+----------------+------------+-------------+------------+------------------------------------------------------------------------------+  
	---------->  Wait 10 seconds for updated options OR  
	---------->  Enter a choice e.g: 1.4 for (1st center 4th slot): 1.3
	```
12. Before the next update, you'll have 10 seconds to provide a choice in the format ```centerIndex.slotIndex``` eg: The input```1.4``` will select the vaccination center in second row and its fourth slot.
