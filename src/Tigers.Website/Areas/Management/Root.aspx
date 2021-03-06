﻿<%@ Page MasterPageFile="~/N2/Simple.master" Language="C#" AutoEventWireup="true" CodeBehind="Root.aspx.cs" Inherits="N2.Templates.Mvc.Areas.Management.Root" %>

<asp:Content ID="ch" ContentPlaceHolderID="Head" runat="server">
	<link href="<%= ResolveClientUrl("~/N2/Resources/Css/Root.css") %>" rel="stylesheet" type="text/css" />
</asp:Content>
<asp:Content ID="cc" ContentPlaceHolderID="Content" runat="server">
	<div id="home">
		<n2:SlidingCurtain ID="sc" runat="server">
			<n2:ControlPanel ID="ControlPanel1" runat="server" EnableEditInterfaceIntegration="false" />
		</n2:SlidingCurtain>
		
		<n2:Zone ID="Zone1" ZoneName="Above" runat="server" />
		<table class="columns">
			<tr>
				<td class="column" runat="server" id="c1">
					<n2:DroppableZone ID="Zone2" ZoneName="Left" runat="server" />
				</td>
				<td class="column" runat="server" id="c2">
					<n2:DroppableZone ID="Zone3" ZoneName="Center" runat="server" />
				</td>
				<td class="column" runat="server" id="c3">
					<n2:DroppableZone ID="Zone4" ZoneName="Right" runat="server" />
				</td>
			</tr>
		</table>
		<n2:Zone ID="Zone5" ZoneName="Below" runat="server" />
	</div>
</asp:Content>