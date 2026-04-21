FROM ubuntu:24.04@sha256:84e77dee7d1bc93fb029a45e3c6cb9d8aa4831ccfcc7103d36e876938d28895b

RUN apt-get update
RUN apt-get install --no-install-recommends -y curl ca-certificates
RUN curl -sSfL https://get.anchore.io/syft | sh -s -- -b /usr/local/bin
RUN curl -sSfL https://get.anchore.io/grype | sh -s -- -b /usr/local/bin
COPY requirements.txt .

COPY entrypoint.sh .

CMD ["bash", "entrypoint.sh"]


