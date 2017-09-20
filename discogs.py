#!/bin/python
import discogs_client
d=discogs_client.Client('FooBarApp/3.0')
rel=d.release(8687623) 
artist = rel.artists 
tracks=rel.tracklist
for track in tracks:
	print str(artist)+str(track)


