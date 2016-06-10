function to_record_input(recorder1)
  f = figure(1) ;
  uicontrol(f,'style','pushbutton','position',[30 120 500 200],'String','Record','CallBack',@buttonCallback) ;
  function buttonCallback(~,~)
      disp('Recording... speak for 15 seconds');
      recorder1.recordblocking(15);
      disp('Stopped.');
  end
end