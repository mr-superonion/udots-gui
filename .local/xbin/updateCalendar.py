#!/usr/bin/env python
from __future__ import print_function
import datetime
import pickle
import os
from googleapiclient.discovery import build
from google_auth_oauthlib.flow import InstalledAppFlow
from google.auth.transport.requests import Request

# If modifying these scopes, delete the file token.pickle.
SCOPES = ['https://www.googleapis.com/auth/calendar.readonly']


def main():
    """Shows basic usage of the Google Calendar API.
    Prints the start and name of the next 10 events on the user's calendar.
    """
    creds = None
    # The file token.pickle stores the user's access and refresh tokens, and is
    # created automatically when the authorization flow completes for the first
    # time.
    if os.path.exists('token.pickle'):
        with open('token.pickle', 'rb') as token:
            creds = pickle.load(token)
    # If there are no (valid) credentials available, let the user log in.
    if not creds or not creds.valid:
        if creds and creds.expired and creds.refresh_token:
            creds.refresh(Request())
        else:
            flow = InstalledAppFlow.from_client_secrets_file(
            os.path.join(os.environ['homeSys'],'xshare/credentials.json'), SCOPES)
            creds = flow.run_local_server(port=0)
        # Save the credentials for the next run
        with open('token.pickle', 'wb') as token:
            pickle.dump(creds, token)

    service = build('calendar', 'v3', credentials=creds)

    # Call the Calendar API
    start_date = datetime.datetime.utcnow()
    end_date = start_date+ datetime.timedelta(days=3)
    start_date=start_date.isoformat() + 'Z' # 'Z' indicates UTC time
    end_date=end_date.isoformat() + 'Z' # 'Z' indicates UTC time

    IdList=['06rrb74vcjkeoatvtefe7ptvn0@group.calendar.google.com','c71eobn4l43merjt5mt2kqfmgs@group.calendar.google.com']
    outFname=os.path.join(os.environ['HOME'],'Tmp/calendar.txt')
    with open(outFname, 'w') as f:
        for thisId in IdList:
            events_result = service.events().list(calendarId=thisId,
                                                timeMin=start_date,
                                                timeMax=end_date,
                                                maxResults=10, singleEvents=True,
                                                orderBy='startTime').execute()
            events = events_result.get('items', [])
            for event in events:
                start = event['start'].get('dateTime', event['start'].get('date'))
                info=start.split('T')
                date=info[0]
                tt=info[1]
                print(date,tt,event['summary'],file=f)

    # page_token = None
    # while True:
    #   calendar_list = service.calendarList().list(pageToken=page_token).execute()
    #   for calendar_list_entry in calendar_list['items']:
    #     print(calendar_list_entry['summary'],calendar_list_entry['id'])
    #   page_token = calendar_list.get('nextPageToken')
    #   if not page_token:
    #     break

if __name__ == '__main__':
    main()
