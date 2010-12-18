/**
 * Created by IntelliJ IDEA.
 * User: sammy
 * Date: 18/12/2010
 * Time: 16:40
 * To change this template use File | Settings | File Templates.
 */
package uk.co.ziazoo.parser
{
  public interface IMemoTable
  {
    function hasResult(id:String, index:int):Boolean;

    function saveResult(id:String, index:int, result:Result):void;

    function getResult(id:String, index:int):Result;
  }
}
