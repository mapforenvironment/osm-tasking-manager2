# -*- coding: utf-8 -*-
<%inherit file="base.mako"/>

<%block name="header"></%block>

<%block name="content">
<div class="container">
  <div class="row">
    <div class="col-md-7">
      <h3>${_('About the Tasking Manager')}</h3>
      <p>
      ${_('Map for Environment - OSM Tasking Manager is a mapping tool designed and built for the Map For Environment collaborative mapping. The purpose of the tool is to divide up a mapping job into smaller tasks that can be completed rapidly. It shows which areas need to be mapped and which areas need the mapping validated. <br />This approach facilitates the distribution of tasks to the various mappers in a context of emergency. It also permits to control the progress and the homogeneity of the work done (ie. Elements to cover, specific tags to use, etc.).')|n}
      </p>
      <h3>${_('Sponsorship and Funding')}</h3>
      <p>${_('OSM Tasking Manager was designed and built for the <a href="http://hotosm.org">Humanitarian OpenStreetMap Team</a>.') |n}
      <img src="${request.static_url('osmtm:static/img/hot.png')}" />

      </p>
    </div>
    <div class="col-md-5">
      <h3>${_('Getting Started')}</h3>
      <p>
        ${_('Some resources to help you start using the Tasking Manager:')}
        <ul>
          <li><a href="http://wiki.openstreetmap.org/wiki/OSM_Tasking_Manager">OSM Wiki</a></li>
          <li><a href="http://learnosm.org/en/coordination/tasking-manager/">LearnOSM</a></li>
          <li><a href="http://mapgive.state.gov/">MapGive</a></li>
        </ul>
      </p>
      <h3>${_('Open Source')}</h3>
      <p>
      ${_('Map for Environment - OSM Tasking Manager is an open source software.<br>Feel free to report issues and contribute.') | n}
      </p>
      <p>${_('The <a href="http://github.com/mapforenvironment/osm-tasking-manager2">application code</a> is available on github') | n}.</p>
<%
      from gitversion import determine_git_version

      ver = determine_git_version('.')
      url = 'https://github.com/mapforenvironment/osm-tasking-manager2/commit/' + ver.rsplit('.',1)[1]
      txt = '<a href="%s">%s</a>' % (url, ver)
%>
      <h3>${_('Version')}</h3>
      <p>
        ${txt |n}
      </p>
    </div>
  </div>
</div>
</%block>
