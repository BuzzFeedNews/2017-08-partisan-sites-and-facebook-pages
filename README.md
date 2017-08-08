# Partisan News Analysis — January 1, 2015 to March 31, 2017

This repository contains data, analytic code, and findings related to the BuzzFeed News article, "[Inside The Partisan Fight For Your News Feed](https://www.buzzfeed.com/craigsilverman/inside-the-partisan-fight-for-your-news-feed)," published August 8, 2017. Please read that article, which contains important context and details, before proceeding.

## Table Of Contents

- [Data](#data)
    - [Raw data](#raw-data)
    - [Output data](#output-data)
- [Reproducibility](#reproducibility)
- [Feedback / Questions?](#feedback--questions)

# Data

## Raw data

The raw, input data for BuzzFeed News’ core analyses come from four sources:

### BuzzFeed News’ list of partisan sites and associated Facebook Pages

The [`data/all-partisan-sites.csv`](data/all-partisan-sites.csv) file represents the list of all 668 websites identified by BuzzFeed News as partisan news outlets, according to the methodology at the bottom of the main article. The data includes each site’s political category (“right” or “left”) and whether BuzzFeed News identified it as being run from Macedonia. The file also includes the Facebook ID numbers for the Facebook Pages, if any, associated with each website at the time of research. In cases where a website is associated with multiple Facebook Pages, there will be multiple rows representing the site.

Facebook IDs are listed in the “unavailable_id” column if the Facebook API would not provide data for that ID at the time it was requested on July 21, 2017. Some are "personal pages", which are akin to public-facing Facebook profiles but not accessible via Facebook's API unless the creator of that page allows it. Another group includes pages that Facebook shut down before we requested their data. Finally, some pages — 24 conservative and 6 liberal, as of July 31 — were unavailable via Facebook's API at the time of our data collection but have since become available or were accessible by checking Facebook manually. None of those 30 pages would have been among the 20 most-popular pages (by fan count) for their respective political categories.

### Overall Facebook page data

The [`data/pages-info.csv`](data/pages-info.csv) file represents a list of all 452 Facebook pages affiliated with the websites identified by BuzzFeed News including title, description, fan count, the page ID, and other information extracted from Facebook’s API.

### Facebook posts

For each Facebook page, we used Facebook’s API to collect all posts published between January 1, 2015 and March 31, 2017. The data included engagement metrics, such as shares, comments, and reactions (likes, loves, hahas, sads etc.). That data is too large to fit in this repository. It can be [found here](https://archive.org/details/partisan-news-facebook-posts-2015-01-01-to-2017-03-31). Note: This data was collected on July 21, 2017. It is possible that some pages deleted posts between when they were published and when the data were collected.

### Domain registration data

The [`data/domaintools-whois-results.csv`](data/domaintools-whois-results.csv) includes the WHOIS registration data, downloaded from DomainTools, for each unique domain — excluding blogging platforms — represented in BuzzFeed News’ list of partisan news outlets.


## Output data

The [analytic code](notebooks) in this repository produces the following data, which are used throughout the article:

### Facebook pages — overview

This file provides an overview of all the Facebook Pages in BuzzFeed News’ list, with each page’s title, fan count, page ID, and political affiliation:

- [`output/fb-page-info-summary.csv`](output/fb-page-info-summary.csv)

The code that produces this output can be found in [`notebooks/00-summarize-fb-page-info.ipynb`](notebooks/00-summarize-fb-page-info.ipynb).

### Facebook pages — per-page engagement metrics

For each page’s posts during each week and month, we calculated the total engagement metrics (shares, comments, and reactions) and number of posts. The resulting files:

- [`output/page-engagement-by-week.csv`](output/page-engagement-by-week.csv)
- [`output/fox-vs-occupy-engagement-by-week.csv`](output/fox-vs-occupy-engagement-by-week.csv) (the weekly total engagement for the Fox News and Occupy Democrats pages)
- [`output/page-engagement-by-month.csv`](output/page-engagement-by-month.csv)

The code that produces these outputs can be found in [`notebooks/01-aggregate-metrics.ipynb`](notebooks/01-aggregate-metrics.ipynb).

### Facebook pages — aggregate engagement metrics

Additionally, we aggregated the engagement metrics for the 100 most-engaged posts on the right and on the left each week:

- [`output/top-100-posts-total-engagement-by-week-and-partisanship.csv`](output/top-100-posts-total-engagement-by-week-and-partisanship.csv)

The code that produces these outputs can also be found in [`notebooks/01-aggregate-metrics.ipynb`](notebooks/01-aggregate-metrics.ipynb).

### Top Facebook posts

Using the data collected from the Facebook API, we identified the top 50 posts (by total engagement) published during the entire timeframe, both overall and by type of post (event, link, music, note, offer, photo, status, video):

- [`output/top-50-posts-all.csv`](output/top-50-posts-all.csv)
- [`output/top-50-posts-event.csv`](output/top-50-posts-event.csv)
- [`output/top-50-posts-link.csv`](output/top-50-posts-link.csv)
- [`output/top-50-posts-music.csv`](output/top-50-posts-music.csv)
- [`output/top-50-posts-note.csv`](output/top-50-posts-note.csv)
- [`output/top-50-posts-offer.csv`](output/top-50-posts-offer.csv)
- [`output/top-50-posts-photo.csv`](output/top-50-posts-photo.csv)
- [`output/top-50-posts-status.csv`](output/top-50-posts-status.csv)
- [`output/top-50-posts-video.csv`](output/top-50-posts-video.csv)

The code that produces these output can also be found in [`notebooks/01-aggregate-metrics.ipynb`](notebooks/01-aggregate-metrics.ipynb).

### Facebook pages — per-page engagement growth

Using the monthly total and median engagement data, we calculated the growth (or decline) in each metric, for each page between March 2016 and March 2017.

- [`output/page-engagement-growth.csv`](output/page-engagement-growth.csv) (growth in total engagements for each Facebook page, its title and its political affiliation)
- [`output/page-engagement-growth-top-20-pages-left.csv`](output/page-engagement-growth-top-20-pages-left.csv) (growth in total engagements  for the top 20 left-leaning Facebook pages, as measured by fan count)
- [`output/page-engagement-growth-top-20-pages-right.csv`](output/page-engagement-growth-top-20-pages-right.csv) (growth in total engagements for the top 20 right-leaning Facebook pages)

The code that produces these outputs can be found in [`notebooks/02-calculate-page-growth.ipynb`](notebooks/02-calculate-page-growth.ipynb).

### Domain registration dates

We used the WHOIS data from DomainTools to calculate the annual and monthly number of registrations for sites in our list, by partisanship:

- [`output/unique-domains.txt`](output/unique-domains.txt) (the list of domain names submitted to DomainTools)
- [`output/whois-registration-dates.csv`](output/whois-registration-dates.csv)
- [`output/whois-registration-counts-annual.csv`](output/whois-registration-counts-annual.csv)
- [`output/whois-registration-counts-monthly.csv`](output/whois-registration-counts-monthly.csv)

The code that produces these outputs can be found in [`notebooks/03-analyze-whois-registration-dates.ipynb`](notebooks/03-analyze-whois-registration-dates.ipynb).

# Reproducibility

To reproduce the findings, you'll need to do the following:

- Ensure that you have installed [Jupyter](http://jupyter.org/), [Python](https://www.python.org/), and the [pandas data-analysis library](https://pandas.pydata.org/) (version 0.19 or higher).
- Download and unzip the [Facebook status data](https://archive.org/details/partisan-news-facebook-posts-2015-01-01-to-2017-03-31) to the [`data/statuses`](data/statuses) path.
- Clear the [`output/`](output/) directory. (Shortcut: run `make clear`.)
- Use Jupyter to run each notebook in the [`notebooks/`](notebooks/) directory consecutively. (Shortcut: run `make reproduce`; requires Python 3.)

# Feedback / Questions?

Contact Lam Thuy Vo at [lam.vo@buzzfeed.com](mailto:lam.vo@buzzfeed.com) and Jeremy Singer-Vine at [jeremy.singer-vine@buzzfeed.com](jeremy.singer-vine@buzzfeed.com).

Looking for more from BuzzFeed News? [Click here for a list of our open-sourced projects, data, and code](https://github.com/BuzzFeedNews/everything).
