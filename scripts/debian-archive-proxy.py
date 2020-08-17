import http.client
import http.server

assert __name__ == '__main__', 'this module should only be executed, not imported'

REAL_HOST = 'snapshot.debian.org'
REAL_PATH = '/archive/debian-ports/20190706T203242Z'

URL_LIST = open('debian-urls.txt', 'w')

class Handler(http.server.BaseHTTPRequestHandler):
    def do_GET(self):
        URL_LIST.write(self.path + '\n')
        URL_LIST.flush()

        conn = http.client.HTTPSConnection(REAL_HOST)
        conn.request('GET', REAL_PATH + self.path)
        resp = conn.getresponse()

        header_dict = dict((k.lower(), v) for (k, v) in resp.getheaders())
        remaining = int(header_dict['content-length'])

        self.send_response(resp.status, resp.reason)
        self.send_header('Content-Length', str(remaining))
        self.end_headers()
        while True:
            b = resp.read(64 * 1024)
            if len(b) == 0:
                break
            remaining -= len(b)
            assert remaining >= 0
            self.wfile.write(b)
        assert remaining == 0

with http.server.HTTPServer(('127.0.0.1', 3142), Handler) as httpd:
    httpd.serve_forever()
