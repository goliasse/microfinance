﻿<%@ Control Language="C#" AutoEventWireup="true" CodeFile="applist.ascx.cs" Inherits="controls_appraisalList" %>
<asp:Table CssClass="table" ID="Table1" runat="server">
</asp:Table>
<div class="row">
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                <div class="text-muted bootstrap-admin-box-title">Bootstrap dataTables</div>
                            </div>
                            <div class="bootstrap-admin-panel-content">
                                <div role="grid" class="dataTables_wrapper form-inline" id="example_wrapper">
                                    <div class="row"><div class="col-md-6">
                                        <div id="example_length" class="dataTables_length"><label><select name="example_length" size="1" aria-controls="example"><option value="10" selected="selected">10</option><option value="25">25</option><option value="50">50</option><option value="100">100</option></select> records per page</label></div></div><div class="col-md-6"><div class="dataTables_filter" id="example_filter"><label>Search: <input type="text" aria-controls="example"></label></div></div></div>
                                        <table id="example" class="table table-striped table-bordered dataTable" aria-describedby="example_info">
                                    <thead>
                                        <tr role="row"><th class="sorting_asc" role="columnheader" tabindex="0" aria-controls="example" rowspan="1" colspan="1" style="width: 168px;" aria-sort="ascending" aria-label="Rendering engine: activate to sort column descending">Rendering engine</th><th class="sorting" role="columnheader" tabindex="0" aria-controls="example" rowspan="1" colspan="1" style="width: 234px;" aria-label="Browser: activate to sort column ascending">Browser</th><th class="sorting" role="columnheader" tabindex="0" aria-controls="example" rowspan="1" colspan="1" style="width: 214px;" aria-label="Platform(s): activate to sort column ascending">Platform(s)</th><th class="sorting" role="columnheader" tabindex="0" aria-controls="example" rowspan="1" colspan="1" style="width: 142px;" aria-label="Engine version: activate to sort column ascending">Engine version</th><th class="sorting" role="columnheader" tabindex="0" aria-controls="example" rowspan="1" colspan="1" style="width: 99px;" aria-label="CSS grade: activate to sort column ascending">CSS grade</th></tr>
                                    </thead>
                                    
                                <tbody role="alert" aria-live="polite" aria-relevant="all"><tr class="gradeA odd">
                                            <td class="  sorting_1">Gecko</td>
                                            <td class=" ">Firefox 1.0</td>
                                            <td class=" ">Win 98+ / OSX.2+</td>
                                            <td class="center ">1.7</td>
                                            <td class="center ">A</td>
                                        </tr><tr class="gradeA even">
                                            <td class="  sorting_1">Gecko</td>
                                            <td class=" ">Firefox 1.5</td>
                                            <td class=" ">Win 98+ / OSX.2+</td>
                                            <td class="center ">1.8</td>
                                            <td class="center ">A</td>
                                        </tr><tr class="gradeA odd">
                                            <td class="  sorting_1">Gecko</td>
                                            <td class=" ">Firefox 2.0</td>
                                            <td class=" ">Win 98+ / OSX.2+</td>
                                            <td class="center ">1.8</td>
                                            <td class="center ">A</td>
                                        </tr><tr class="gradeA even">
                                            <td class="  sorting_1">Gecko</td>
                                            <td class=" ">Firefox 3.0</td>
                                            <td class=" ">Win 2k+ / OSX.3+</td>
                                            <td class="center ">1.9</td>
                                            <td class="center ">A</td>
                                        </tr><tr class="gradeA odd">
                                            <td class="  sorting_1">Gecko</td>
                                            <td class=" ">Camino 1.0</td>
                                            <td class=" ">OSX.2+</td>
                                            <td class="center ">1.8</td>
                                            <td class="center ">A</td>
                                        </tr><tr class="gradeA even">
                                            <td class="  sorting_1">Gecko</td>
                                            <td class=" ">Camino 1.5</td>
                                            <td class=" ">OSX.3+</td>
                                            <td class="center ">1.8</td>
                                            <td class="center ">A</td>
                                        </tr><tr class="gradeA odd">
                                            <td class="  sorting_1">Gecko</td>
                                            <td class=" ">Netscape 7.2</td>
                                            <td class=" ">Win 95+ / Mac OS 8.6-9.2</td>
                                            <td class="center ">1.7</td>
                                            <td class="center ">A</td>
                                        </tr><tr class="gradeA even">
                                            <td class="  sorting_1">Gecko</td>
                                            <td class=" ">Netscape Browser 8</td>
                                            <td class=" ">Win 98SE+</td>
                                            <td class="center ">1.7</td>
                                            <td class="center ">A</td>
                                        </tr><tr class="gradeA odd">
                                            <td class="  sorting_1">Gecko</td>
                                            <td class=" ">Netscape Navigator 9</td>
                                            <td class=" ">Win 98+ / OSX.2+</td>
                                            <td class="center ">1.8</td>
                                            <td class="center ">A</td>
                                        </tr><tr class="gradeA even">
                                            <td class="  sorting_1">Gecko</td>
                                            <td class=" ">Mozilla 1.0</td>
                                            <td class=" ">Win 95+ / OSX.1+</td>
                                            <td class="center ">1</td>
                                            <td class="center ">A</td>
                                        </tr></tbody>
                                 </table>
                                    <div class="row">
                                        <div class="col-md-6">
                                            <div class="dataTables_info" id="example_info">Showing 1 to 10 of 57 entries</div>
                                            </div><div class="col-md-6">
                                        <div class="dataTables_paginate paging_bootstrap">
                                            <ul class="pagination"><li class="prev disabled">
                                                <a href="#">← Previous</a></li>
                                                <li class="active"><a href="#">1</a></li>
                                                <li><a href="#">2</a></li>
                                                <li><a href="#">3</a></li>
                                                <li><a href="#">4</a></li>
                                                <li><a href="#">5</a></li>
                                                <li class="next"><a href="#">Next → </a></li>
                                                </ul>
                                           </div>
                                          </div>
                                          </div>
                                       </div>
                            </div>
                        </div>
                    </div>