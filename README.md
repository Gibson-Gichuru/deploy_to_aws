
# API Deployment 

This Repo showcase the minimal setup for an api deployment to an AWS EC2 instance using github actions.  

The API is ony deployed once all the unittests have passed and the source code have succesfuly been linted



## Installation

Install this project by cloning the repository and creating 
a virual python environment within the root directory of the project

On an activated python environment run:

```bash
  pip install -r requirements.txt
```
    
## Running

To run the development server run:
```bash
  flask run 
```
## Testing

The application can be tested using:

```bash
    flask test
```

