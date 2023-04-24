import React from 'react';
import clsx from 'clsx';
import styles from './HomepageFeatures.module.css';
import Translate from '@docusaurus/Translate';

const FeatureList = [
    {
        title: (<Translate description="Features Time management title">Time management</Translate>),
        Svg: require('../../static/img/undraw_time_management_30iu.svg').default,
        description: (
            <Translate description="Features Time management description">
                Manage the time efficiency and automate it.
            </Translate>
        ),
    },
    {
        title: (<Translate description="Features Event management title">Event management</Translate>),
        Svg: require('../../static/img/undraw_Schedule_re_2vro.svg').default,
        description: (
            <Translate description="Features Event management description">
                Schedule events, assign users to it and give tasks to them
            </Translate>
        ),
    },
  {
    title: (<Translate description="Features Your data title">Your data</Translate>),
    Svg: require('../../static/img/undraw_personal_data_29co.svg').default,
    description: (
      <Translate description="Features Your data description">
          Everyone can create their own server and have your data on it.
      </Translate>
    ),
  },
  {
    title: (<Translate description="Features Open source title">Open source</Translate>),
    Svg: require('../../static/img/undraw_open_source_1qxw.svg').default,
    description: (
      <Translate description="Features Open source description">
          The app and the server are all open source. Everyone can contribute!
      </Translate>
    ),
  },
];

function Feature({Svg, title, description}) {
  return (
    <div className={clsx('col col--3')}>
      <div className="text--center">
        <Svg className={styles.featureSvg} alt={title} />
      </div>
      <div className="text--center padding-horiz--md">
        <h3>{title}</h3>
        <p>{description}</p>
      </div>
    </div>
  );
}

export default function HomepageFeatures() {
  return (
    <section data-aos="fade-up" className={styles.features}>
      <div className="container">
        <div className="row">
          {FeatureList.map((props, idx) => (
            <Feature key={idx} {...props} />
          ))}
        </div>
      </div>
    </section>
  );
}
