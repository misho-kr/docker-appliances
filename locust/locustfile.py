from locust import HttpLocust, TaskSet

def version(l):
    l.client.get("/alpha/version")

def list_jobs(l):
    l.client.get("/alpha/jobs/paas-aurora/mkrastev")

class UserBehavior(TaskSet):
    tasks = { version: 1, list_jobs: 2 }

class WebsiteUser(HttpLocust):
    task_set = UserBehavior
    min_wait=1000
    max_wait=3000
