# coding: utf-8
import argparse
from BaseHTTPServer import BaseHTTPRequestHandler, HTTPServer
import re
import urllib
import webbrowser

ADDRESS = 'https://habrahabr.ru'
PORT = 8000
HOST = 'localhost'
WORD_LENGTH = 6

parser = argparse.ArgumentParser(description='Proxy server™')
parser.add_argument('--address', type=str, nargs='?', required=False)
parser.add_argument('--port', type=int, nargs='?', required=False)
parser.add_argument('--host', type=str, nargs='?', required=False)


class HttpProcessor(BaseHTTPRequestHandler):

    def do_GET(self):
        self.send_response(200)
        self.send_header('content-type', 'text/html')
        self.end_headers()
        self.wfile.write(self.get_site())

    def get_site(self):
        response = urllib.urlopen('%s%s' % (self.address, self.path))
        self.charset = response.headers.getparam('charset')
        if response.info().type == 'text/html':
            html = self.prepare_html(response.read().decode(self.charset))
            return self.update_links(html)
        return response.read()

    def update_links(self, s):
        return s.replace(ADDRESS, 'http://%s:%s' % (HOST, PORT))

    def prepare_html(self, s):
        out = ""
        tag, quote, ignore_content = False, False, False
        last_whitespace, current_whitespace = -1, -1
        last_tag_closing = 0
        for i, c in enumerate(s):
            if ignore_content:
                ignore_content = not (s[i+1:].startswith(u'/script') or
                                      s[i+1:].startswith(u'/style'))
                out = out + c
                continue
            if c == '<' and not quote:
                tag = True
                ignore_content = (s[i+1:].startswith(u'script') or
                                  s[i+1:].startswith(u'style'))
                last_whitespace, current_whitespace = current_whitespace, i
                if current_whitespace - last_whitespace == WORD_LENGTH + 1:
                    if last_tag_closing <= last_whitespace:
                        out = out + u'™'
            elif c == '>' and not quote:
                tag = False
                last_tag_closing = i
                last_whitespace, current_whitespace = current_whitespace, i
            elif (c == '"' or c == "'") and tag:
                quote = not quote
            elif not (tag or ignore_content):
                if not re.search(u'[A-Za-zА-Яа-я]+', c):
                    last_whitespace, current_whitespace = current_whitespace, i
                    if current_whitespace - last_whitespace == WORD_LENGTH + 1:
                        if last_tag_closing <= last_whitespace:
                            out = out + u'™'
            out = out + c
        return out.encode(self.charset)


if __name__ == "__main__":
    args = vars(parser.parse_args())
    PORT = args.get('port') or PORT
    HOST = args.get('host') or HOST
    ADDRESS = args.get('address') or ADDRESS

    HttpProcessor.address = ADDRESS

    server = HTTPServer((HOST, PORT), HttpProcessor)
    webbrowser.open_new_tab('http://%s:%s' % (HOST, PORT))
    server.serve_forever()
