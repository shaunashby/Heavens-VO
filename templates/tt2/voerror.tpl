  <INFO name="QUERY_STATUS" value="[% query_status %]">
[% FOREACH error IN context.errors -%]
      errorMessage = VO::QueryStatus::[% error.type %] - [% error.what -%]
[% END %]
  </INFO>
