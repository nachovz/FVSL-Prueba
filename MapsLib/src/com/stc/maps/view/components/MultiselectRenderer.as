package com.stc.maps.view.components
{
	import com.stc.maps.view.components.event.MultiselectSelectionEvent;
	
	import mx.collections.ArrayCollection;
	import mx.containers.HBox;
	import mx.containers.VBox;
	import mx.containers.ViewStack;
	import mx.controls.CheckBox;
	import mx.controls.Label;
	import mx.controls.LinkButton;
	import mx.controls.List;
	import mx.controls.TextArea;
	import mx.core.ClassFactory;
/* 	IMPORT FLASH.EVENTS.MOUSEEVENT; */
 	import flash.events.MouseEvent;
/*  	import flash.events.MouseEvent; */

	public class MultiselectRenderer extends ViewStack
	{
 		private var multiSelector : List = new List();
		private var textArea : TextArea = new TextArea();
		private var _label : Label = new Label();
		private var editLink : LinkButton = new LinkButton();
		private var doneLink : LinkButton = new LinkButton();
		
		private var showSelected : VBox = new VBox();
		private var editSelected : VBox = new VBox(); 
		
		private var _selectedCriterias : ArrayCollection = new ArrayCollection();
		private var _dataProvider : ArrayCollection;
		private var dataproviderChange : Boolean;
		private var selectedCriteriasChange : Boolean;
		
		public var titleLabel : String = "label";
		
		public function set labelOption(value : String):void
		{
			_label.text = value;
		}
		
		public function get labelOption() : String
		{
			return _label.text;
		}
		
		public function MultiselectRenderer()
		{
			super();
		}
		
		public function set dataProvider(value : ArrayCollection) : void
		{
			if(value)
			{
				_dataProvider = value;
				dataproviderChange = true;
				
				invalidateProperties();
			}
		}

		public function get dataProvider() : ArrayCollection
		{
			return _dataProvider;
		}

		public function set selectedCriterias(value : ArrayCollection) : void
		{
			if(value && value.length>0)
			{
				_selectedCriterias = value;
				selectedCriteriasChange = true;
			}
		}
		
		public function getSelectedValuesByComa() : String
		{
			var text : String = "";
			if(selectedCriterias)
				for(var i : int = 0; i<selectedCriterias.length;i++)
				{
					text += selectedCriterias[i]["id"];
					text += (i<selectedCriterias.length-1) ? "," : "";
				}
			
			return text;
		}

		public function get selectedCriterias() : ArrayCollection
		{
			return _selectedCriterias;
		}
		
 		override protected function createChildren():void
		{
			super.createChildren();
			
 			textArea.text = "No hay criterios";
 			textArea.setStyle("borderStyle","none");
 			textArea.wordWrap = true;
			editLink.label = "Seleccionar criterios";
			doneLink.label = "Cerrar";
			textArea.editable = false;
			textArea.height = 24;
			textArea.percentWidth = 100;
			multiSelector.percentWidth = 100;
			multiSelector.height = 100;
			multiSelector.itemRenderer = new ClassFactory(com.stc.maps.view.components.MultiselectItemRenderer);
			//multiSelector.allowMultipleSelection = true;
			showSelected.setStyle("horizontalAlign","right");
			editSelected.setStyle("horizontalAlign","right");
			showSelected.setStyle("verticalGap","0");
			editSelected.setStyle("verticalGap","0");
			multiSelector.setStyle("color","0x000000");
			showSelected.percentWidth = 100;
			editSelected.percentWidth = 100;

			editLink.addEventListener(MouseEvent.CLICK,editLink_click);
			
			var hbx : HBox = new HBox();
			hbx.percentWidth = 100;
			hbx.addChild(_label);
 			_label.setStyle("fontWeight","bold");
			hbx.addChild(editLink);
			showSelected.addChild(hbx);
			
			showSelected.addChild(textArea);
			editSelected.addChild(multiSelector);
			editSelected.addChild(doneLink);
			
			this.addChild(showSelected);
			this.addChild(editSelected); 


		}
		
		override protected function commitProperties():void
		{
			super.commitProperties();
			
			if(dataproviderChange)
			{
				selectedCriterias = new ArrayCollection();
				multiSelector.dataProvider = dataProvider;
				dataproviderChange = false;
			}
			if(selectedCriteriasChange)
			{
				textArea.text = "";
				for(var i : int = 0; i<selectedCriterias.length;i++)
				{
					textArea.text += selectedCriterias[i][titleLabel];
					textArea.text += (i<selectedCriterias.length-1) ? ", " : ".";
				}
				
				textArea.height=textArea.textHeight + 10;
				
				selectedCriteriasChange = false;
			}
		}
		
		private function editLink_click(event : MouseEvent) : void
		{
			selectedIndex = 1;
			editLink.removeEventListener(MouseEvent.CLICK,editLink_click);
			doneLink.addEventListener(MouseEvent.CLICK,doneLink_click);
			this.addEventListener(MultiselectSelectionEvent.SELECT_ITEM,list_select);
			this.addEventListener(MultiselectSelectionEvent.DESELECT_ITEM,list_deselect);
			this.height = multiSelector.height+doneLink.height;
		}

		private function doneLink_click(event : MouseEvent) : void
		{
			selectedIndex = 0;
			editLink.addEventListener(MouseEvent.CLICK,editLink_click);
			doneLink.removeEventListener(MouseEvent.CLICK,doneLink_click);
			this.removeEventListener(MultiselectSelectionEvent.SELECT_ITEM,list_select);
			this.removeEventListener(MultiselectSelectionEvent.DESELECT_ITEM,list_deselect);
			selectedCriterias = selectedCriterias;
			this.height = showSelected.height;
		}
		
		private function list_select(e:MultiselectSelectionEvent):void
		{
           if(selectedCriterias.getItemIndex(e.item)==-1)
           {
               selectedCriterias.addItem(e.item);
           }    
		   //multiSelector.selectedItems = selectedCriterias;               
		}	
		
		private function list_deselect(e:MultiselectSelectionEvent):void
		{
           if(selectedCriterias.getItemIndex(e.item)!=-1)
           {
               selectedCriterias.removeItemAt(selectedCriterias.getItemIndex(e.item));
           }    
		   //multiSelector.selectedItems = selectedCriterias;               
		}	
		
	}
}