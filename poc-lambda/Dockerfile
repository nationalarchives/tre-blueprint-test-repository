ARG python_version=3.9
FROM public.ecr.aws/lambda/python:${python_version}

# Copy function code
COPY handler.py ${LAMBDA_TASK_ROOT}

# Install function's dependencies using file requirements.txt
COPY requirements.txt ./requirements.txt
RUN  yum -y update \
     && yum clean all \
     && pip3 install -r requirements.txt --target "${LAMBDA_TASK_ROOT}"

# Set the CMD to your handler (could also be done as a parameter override outside of the Dockerfile)
CMD [ "handler.handler" ]
