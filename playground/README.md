OpenCopilot playground
---


## Running locally:

```shell
cd playground
cp frontend.env.example frontend.env
cp opencopilot.env.example opencopilot.env

vi opencopilot.env
```
Update the env file to contain your proper secrets:


### Confluence Key

To scrape confluence data into weaviate, you first need to create a token for your confluence user. 

Log into confluence, and go to your "Manage Account" (from the top right profile menu). Then, from the
top menu, select "Security" and then "Create and manage API tokens". Create a new api token and then
copy into the CONFLUENCE_API_KEY env variable in the opencopilot.env file, along with the login email
for your confluence account.

### OpenAI key
You will need to insert your OpenAI key into openCopilot per their docs. https://platform.openai.com/account/api-keys

### Startup

Once your env is setup, you can start the stack with docker-compose. The compose file provided makes the following assumptions:

```shell
mkdir weaviate-data
docker-compose up --build  # optionally add -d to run in the background

```

### Stopping it
```shell
docker-compose down
```