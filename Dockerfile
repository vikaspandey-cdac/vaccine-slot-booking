# set base image (host OS)
FROM python:3.9.4-slim-buster

# set the working directory in the container
WORKDIR /code

# copy the dependencies file to the working directory
COPY requirements.txt .

# install dependencies
RUN pip install --trusted-host pypi.org --trusted-host files.pythonhosted.org -r requirements.txt

# copy the content of the local src directory to the working directory
COPY slot_booking.py .
COPY utils.py .

# command to run on container start
CMD [ "python", "./slot_booking.py" ]